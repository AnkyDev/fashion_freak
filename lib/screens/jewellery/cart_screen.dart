import 'dart:async';
import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Prefs.dart';
import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/models/UserModel.dart';
import 'package:fasion_freak_flutter/models/voucher_model.dart';
import 'package:fasion_freak_flutter/screens/helper/addaccount_screen.dart';
import 'package:fasion_freak_flutter/screens/jewellery/Home_screen.dart';
import 'package:fasion_freak_flutter/screens/jewellery/cart_listview_screen.dart';
import 'package:fasion_freak_flutter/screens/jewellery/payment_jwellery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';

class cartScreen extends StatefulWidget {
  const cartScreen({Key? key}) : super(key: key);

  @override
  _cartScreenState createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  TextEditingController vouchercoupen = TextEditingController();
  Map<dynamic, dynamic> CartMap = {};
  List<productmodel> CartProducts = [];
  List<vouchermodel> voucher = [];
  List<dynamic> qty = [];
  List<productmodel> allproducts = [];
  bool deleteItem = false;
  bool noItems = false;
  late String date;
  late String time;

  void _getTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    setState(() {
      date = formatter.format(now);
      time = now.hour.toString() + ":" + now.minute.toString();
    });
  }

  //total price
  late String total;

  static late AppUser user;
  Future<void> totalprice() async {
    user = await Prefs.getUser();

    DatabaseReference dbref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    dbref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart")
        .child('totalprice');
    await dbref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        total = snapshot.value['totalprice'].toString();
      }
    });
  }

  //razor pay instance
  Razorpay _razorpay = Razorpay();

  Future<void> getAllProducts() async {
    allproducts = await Realtimedb.getAllProducts();
    setState(() {});
  }

  Future<void> getCartList() async {
    CartMap = await Realtimedb.getKartList();
    setState(() {});
  }

  Future<void> getvoucherlist() async {
    voucher = await Realtimedb.getAllvoucher();
    print(voucher.length);
    setState(() {});
  }

  Future<void> finalize() async {
    setState(() {
      // isLoading = true;
    });
    await getAllProducts();
    await getCartList();

    if (CartMap == null) {
      setState(() {
        noItems = true;
      });
    } else {
      qty = CartMap.values.toList();
      CartMap.keys.forEach((CartElement) {
        allproducts.forEach((element) {
          if (element.productid == CartElement) {
            CartProducts.add(element);
          }
        });
      });
    }
    setState(() {
      //isLoading = false;
    });
  }

  @override
  void initState() {
    finalize();
    getvoucherlist();
    //print(voucher[1].vouchername.toString());
    totalprice();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void opencheckout() {
    var options = {
      "key": "rzp_test_Q1er41iZtbxOKR",
      "amount": num.parse(total) * 100,
      "name": "Fashion Freak",
      "description": CartProducts.toString(),
      "prefill": {"contact": user.mobile.toString()},
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print(response.paymentId);
    int count = 0;
    print(CartProducts.length);
    print(CartProducts);
    for (int i = 0; i < CartProducts.length; i++) {
      print(CartProducts[i].imgUrl);
      print(CartProducts[i].price);
      print(CartProducts[i].title);
      Realtimedb.addToOrder(
          CartProducts[i], qty[i].toString(), "razorpay", date, time);
      // for (int j = 0; j < int.parse(qty[i]); j++) {

      // }

    }
    for (int i = 0; i < CartProducts.length; i++) {
      count++;
      print(count);
      print('working');
      //print(int.parse(qty[i]));
      // Realtimedb.addToOrder(
      //     CartProducts[i], qty[i].toString(), "razorpay", date, time);
      CartProducts.removeWhere(
          (element) => element.productid == CartProducts[i].productid);
      print(CartProducts.length);
      // for (int j = 0; j < int.parse(qty[i]); j++) {

      // }
    }
    print('out of loop');
    Realtimedb.deleteCart();

    // setState(() {
    //   CartProducts == 0;
    // });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Order Placed Successfully!')));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (builder) => Homescreen()),
        (route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.message)));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Grid view for cart products
            Container(
              //child: //Text('hello'),
              //CartListviewScreen(),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: CartProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    offset: Offset(0.9, 0.9),
                                    spreadRadius: 0.1)
                              ]),
                          child: Row(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    CartProducts[index].imgUrl,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        CartProducts[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        "₹ " + CartProducts[index].price,
                                        // style: textStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        "Qty : " + qty[index].toString(),
                                        // style: textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: () async {
                                      await Realtimedb.deleteFromCart(
                                          CartProducts[index].productid,
                                          CartProducts[index].price,
                                          qty[index].toString());
                                     

                                      await getCartList();
                                      if (CartMap == null) {
                                        setState(() {
                                          noItems = true;
                                        });
                                      }
                                      CartProducts.removeWhere((element) =>
                                          element.productid ==
                                          CartProducts[index].productid);
                                       setState(() {
                                        print('item deleted');
                                      });    
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  }),
            ),

            //pin check box
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: vouchercoupen,
                        decoration: InputDecoration(
                          hintText: "Enter Coupon Code",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: FlatButton(
                      onPressed: () {
                        //check voucher is compitable or not
                        if (voucher != null) {
                          voucher.forEach((element) {
                            if (element.vouchername.toString() ==
                                vouchercoupen.text.toString()) {
                              //apply coupen code
                              Realtimedb.applyvoucher(element.amount.toString(),
                                  vouchercoupen.text);
                              setState(() {
                                total = (int.parse(total) -
                                        int.parse(element.amount))
                                    .toString();
                              });
                            }
                          });
                        }
                      },
                      child:
                          Text("Apply", style: TextStyle(color: Colors.white)),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Card(
            //   color: Colors.white,
            //   elevation: 6.0,
            //   margin: EdgeInsets.only(right: 15.0, left: 15.0),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       const ListTile(
            //         leading: Icon(
            //           Icons.home_rounded,
            //           color: Colors.black,
            //         ),
            //         title: Text(
            //           'Address',
            //           style: TextStyle(color: Colors.black),
            //         ),
            //         subtitle: Text('131 Street Road, Boston, NewYork'),
            //       ),
            //       Container(
            //         height: 70,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(5.0),
            //         ),
            //         child: Padding(
            //           padding: EdgeInsets.all(15),
            //           child: TextButton.icon(
            //             icon: Icon(Icons.add),
            //             label: Text(
            //               'Add Address',
            //             ),
            //             onPressed: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (builder) => addaccount()));
            //             },
            //             style: ButtonStyle(
            //                 foregroundColor:
            //                     MaterialStateProperty.all<Color>(Colors.white),
            //                 backgroundColor:
            //                     MaterialStateProperty.all<Color>(Colors.black),
            //                 shape: MaterialStateProperty.all<
            //                         RoundedRectangleBorder>(
            //                     RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(5),
            //                         side: BorderSide(color: Colors.black)))),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //price details
          ],
        ),
      ),

      //place order button
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: () {
              if (CartProducts.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please add some items')));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => PaymentJwellery(
                          CartProducts: CartProducts,
                          qty: qty,
                          date: date,
                          time: time,
                          total: total,
                        )));
              }
              //payment and db
              //  opencheckout();
            },
            child: Text(
              'Place Order',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
