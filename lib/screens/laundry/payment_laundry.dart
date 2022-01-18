import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Prefs.dart';
import 'package:fasion_freak_flutter/models/UserModel.dart';
import 'package:fasion_freak_flutter/models/laundry_model.dart';
import 'package:fasion_freak_flutter/screens/helper/addaccount_laundry.dart';
import 'package:fasion_freak_flutter/screens/helper/addaccount_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentLaundry extends StatefulWidget {
  final String selectedDate;
  final String dateFix;
  final String timeFix;
  final String selectedTime;
  final String city;

  final List<LaundryModel> selectedLaundry;
  PaymentLaundry(
      {required this.dateFix,
      required this.timeFix,
      required this.selectedLaundry,
      required this.selectedDate,
      required this.selectedTime,
      required this.city});

  @override
  _PaymentLaundryState createState() => _PaymentLaundryState();
}

class _PaymentLaundryState extends State<PaymentLaundry> {
  Razorpay _razorpay = Razorpay();
  static late AppUser user;
  String address = '';
  Future<void> getUserId() async {
    user = await Prefs.getUser();
  }

  void opencheckout() {
    var options = {
      "key": "rzp_test_Q1er41iZtbxOKR",
      "amount": num.parse('100') * 100,
      "name": "Fashion Freak",
      "description": 'ALL ITEMS', //CartProducts.toString(),
      "prefill": {"contact": user.mobile.toString()},
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  void CodOrder() async {
    // print(response.paymentId);
    String dateYear = widget.dateFix.substring(0, 4);
    print(dateYear);

    for (int i = 0; i < widget.selectedLaundry.length; i++) {
      await Realtimedb.addToOrderLaundry(
          widget.selectedLaundry[i],
          'Cash On Delivery',
          widget.selectedDate,
          widget.dateFix,
          '12345',
          widget.timeFix,widget.city);
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request Accepted Successfully!')));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<void> getAdrrreess() async {
    address = await Realtimedb.getAddress();
    print(address);
    setState(() {
      print('doneeee');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    getAdrrreess();
    // address = Realtimedb.getAddress() as String;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print(response.paymentId);
    String dateYear = widget.dateFix.substring(0, 4);
    print(dateYear);

    for (int i = 0; i < widget.selectedLaundry.length; i++) {
      await Realtimedb.addToOrderLaundry(
          widget.selectedLaundry[i],
          'RazorPay',
          widget.selectedDate,
          widget.dateFix,
          response.paymentId,
          widget.timeFix,widget.city);
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request Accepted Successfully!')));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
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
        backgroundColor: Colors.green,
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
                                builder: (builder) => AddaccountLaundry(
                                    dateFix: widget.dateFix,
                                    selectedDate: widget.selectedDate,
                                    selectedTime: widget.selectedTime,
                                    selectedlaundry: widget.selectedLaundry,
                                    timeFix: widget.timeFix,
                                    city: widget.city,)));
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
            height: 100,
          ),
          // Container(
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(8)),
          //       color: Colors.green),
          //   // color: Colors.green,
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
