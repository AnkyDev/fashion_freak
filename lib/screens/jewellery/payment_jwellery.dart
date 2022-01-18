import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Prefs.dart';
import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/models/UserModel.dart';
import 'package:fasion_freak_flutter/screens/helper/addaccount_screen.dart';
import 'package:fasion_freak_flutter/screens/jewellery/Home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentJwellery extends StatefulWidget {
  List<dynamic> qty = [];
  List<productmodel> CartProducts = [];
  String total;
  String date;
  String time;
  PaymentJwellery(
      {required this.CartProducts,
      required this.qty,
      required this.total,
      required this.date,
      required this.time});

  @override
  _PaymentJwelleryState createState() => _PaymentJwelleryState();
}

class _PaymentJwelleryState extends State<PaymentJwellery> {
  Razorpay _razorpay = Razorpay();
  static late AppUser user;
  bool counter = false;
  String address = '';
  Future<void> getUserId() async {
    user = await Prefs.getUser();
  }

  void opencheckout() {
    var options = {
      "key": "rzp_test_Q1er41iZtbxOKR",
      "amount": counter == true
          ? (num.parse(widget.total) - 10) * 100
          : (num.parse(widget.total)) * 100,
      "name": "Fashion Freak",
      "description": widget.CartProducts.toString(),
      "prefill": {"contact": user.mobile.toString()},
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  Future<void> getAdrrreess() async {
    address = await Realtimedb.getAddress();
    print(address);
    setState(() {
      print('doneeee');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  @override
  void initState() {
    getUserId();
    getAdrrreess();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  void CodOrder() {
    int count = 0;
    print(widget.CartProducts.length);
    print(widget.CartProducts);
    for (int i = 0; i < widget.CartProducts.length; i++) {
      print(widget.CartProducts[i].imgUrl);
      print(widget.CartProducts[i].price);
      print(widget.CartProducts[i].title);
      Realtimedb.addToOrder(widget.CartProducts[i], widget.qty[i].toString(),
          "Cash On Delivery", widget.date, widget.time);

      // for (int j = 0; j < int.parse(widget.qty[i].toString()); j++) {

      // }

    }
    for (int i = 0; i < widget.CartProducts.length; i++) {
      count++;
      print(count);
      print('working');
      //print(int.parse(qty[i]));
      // Realtimedb.addToOrder(
      //     CartProducts[i], qty[i].toString(), "razorpay", date, time);
      widget.CartProducts.removeWhere(
          (element) => element.productid == widget.CartProducts[i].productid);
      print(widget.CartProducts.length);
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print(response.paymentId);
    int count = 0;
    print(widget.CartProducts.length);
    print(widget.CartProducts);
    for (int i = 0; i < widget.CartProducts.length; i++) {
      print(widget.CartProducts[i].imgUrl);
      print(widget.CartProducts[i].price);
      print(widget.CartProducts[i].title);
      Realtimedb.addToOrder(widget.CartProducts[i], widget.qty[i].toString(),
          "razorpay", widget.date, widget.time);

      // for (int j = 0; j < int.parse(widget.qty[i].toString()); j++) {

      // }

    }
    for (int i = 0; i < widget.CartProducts.length; i++) {
      count++;
      print(count);
      print('working');
      //print(int.parse(qty[i]));
      // Realtimedb.addToOrder(
      //     CartProducts[i], qty[i].toString(), "razorpay", date, time);
      widget.CartProducts.removeWhere(
          (element) => element.productid == widget.CartProducts[i].productid);
      print(widget.CartProducts.length);
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
      appBar: AppBar(
        title: Text('Place Order'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(7),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter address here',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 6.0,
            margin: EdgeInsets.only(right: 15.0, left: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home_rounded,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Address',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(address),
                  // trailing: Text(address.toString()),
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: TextButton.icon(
                      icon: Icon(Icons.add),
                      label: Text(
                        'Add Address',
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => addaccount()));
                      },
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black)))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(6),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Do You want to use Reward Points?',
                    style: TextStyle(fontSize: 17),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          counter = !counter;
                        });
                      },
                      child: counter == false
                          ? Text(
                              'Yes',
                              style: TextStyle(fontSize: 17),
                            )
                          : Text(
                              'No',
                              style: TextStyle(fontSize: 17),
                            )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total Amount :  ₹ ',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Text(widget.total,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          // Container(
          //   decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: Colors.green),
          //  // color: Colors.green,
          //   child: TextButton(
          //     onPressed: () {
          //       CodOrder();
          //     },
          //     child: Text(
          //       'Cash On Delivery',
          //       style: TextStyle(fontSize: 18, color: Colors.white),
          //     ),
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 20,
              padding: const EdgeInsets.all(2.0),
              child: FlatButton(
                onPressed: () {
                  CodOrder();
                },
                child: Text(
                  'Cash On delivery',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.green,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              padding: const EdgeInsets.all(4.0),
              child: FlatButton(
                onPressed: () {
                  print('Running payment');
                  opencheckout();
                },
                child: Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.green,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
    );
  }
}
