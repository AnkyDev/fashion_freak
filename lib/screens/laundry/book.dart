import 'dart:async';

import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Prefs.dart';
import 'package:fasion_freak_flutter/models/UserModel.dart';
import 'package:fasion_freak_flutter/models/laundry_model.dart';
import 'package:fasion_freak_flutter/screens/laundry/payment_laundry.dart';
import 'package:fasion_freak_flutter/widgets/laundryy.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Book extends StatefulWidget {
  final String city;
  Book(this.city);
  @override
  _BookState createState() => _BookState();
}

List<LaundryModel> selectedLaundry = [];

void addToLundryList(LaundryModel data) {
  if (!selectedLaundry.contains(data)) {
    selectedLaundry.add(data);
  } else {
    selectedLaundry.remove(data);
  }
  // print(selectedLaundry[0].price);
  // print(selectedLaundry[0].title);
  print(data.price);
  print(data.title);
  print(selectedLaundry.length);
}

class _BookState extends State<Book> {
  // String selectDate = '', selectDay = '';
  // int selected = 0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool count1 = false;
  bool count2 = false;

  List<LaundryModel> allLaundry = [];
  late String dateFix;
  late String timeFix;

  void _getTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    setState(() {
      dateFix = formatter.format(now);
      timeFix = now.hour.toString() + ":" + now.minute.toString();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        count1 = true;
      });
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        // builder: (BuildContext ctx,){

        // }
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null && pickedS != selectedTime)
      setState(() {
        selectedTime = pickedS;
        count2 = true;
      });
  }

  Future<void> getAllLaundries() async {
    allLaundry = await Realtimedb.getLaundryDetails().then((value) {
      setState(() {});
      return value;
    });
  }

  static late AppUser user;
  Future<void> getUserId() async {
    user = await Prefs.getUser();
  }

  // Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    super.initState();

    getAllLaundries();
    getUserId();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());

    print(allLaundry.length);
  }

  // void opencheckout() {
  //   var options = {
  //     "key": "rzp_test_Q1er41iZtbxOKR",
  //     "amount": num.parse('100') * 100,
  //     "name": "Fashion Freak",
  //     "description": 'ALL ITEMS', //CartProducts.toString(),
  //     "prefill": {"contact": user.mobile.toString()},
  //     "external": {
  //       "wallets": ["paytm"]
  //     }
  //   };
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {}
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _razorpay.clear();
  // }

  // Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   // Do something when payment succeeds
  //   print(response.paymentId);
  //   String dateYear = dateFix.substring(0, 4);
  //   print(dateYear);

  //   for (int i = 0; i < selectedLaundry.length; i++) {
  //     await Realtimedb.addToOrderLaundry(
  //         selectedLaundry[i],
  //         'RazorPay',
  //         selectedDate.toString().substring(0,11),
  //        // '$selectDate-$selectDay-$dateYear',
  //         dateFix,
  //         response.paymentId,
  //         timeFix );
  //   }
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text('Success')));
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(response.message)));
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SCHEDULE PICKUP'),
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      'Select Date',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(selectedTime.format(context)),
            //  Text(selectedTime.format(context)),
            SizedBox(
              height: 5,
            ),
            Center(
              child: ElevatedButton(
                child: Text('Select Time'),
                onPressed: () => selectTime(context),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ),
            // Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(18.0),
            //       child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: Text(
            //           'Select Date And Time',
            //           style: TextStyle(fontSize: 24, color: Colors.grey),
            //           //  textAlign: TextAlign.start,
            //         ),
            //       ),
            //     )
            //   ],
            // ),

            // Column(
            //   children: <Widget>[
            //     Text(
            //         selected == null
            //             ? 'No selected date'
            //             : 'Selected date $selectDate - $selectDay',
            //         style: TextStyle(fontStyle: FontStyle.italic)),
            //     SizedBox(
            //       height: 20,
            //     ),
            //     Container(
            //       height: 115,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(15),
            //           bottomLeft: Radius.circular(15),
            //         ),
            //       ),
            //       padding: EdgeInsets.all(15),
            //       child: ListView.builder(
            //         itemCount: 12,
            //         scrollDirection: Axis.horizontal,
            //         itemBuilder: (ctx, position) {
            //           int day = DateTime.now().day + position;
            //           return GestureDetector(
            //               child: FittedBox(
            //                   child: Container(
            //                       height: 90,
            //                       width: 90,
            //                       margin: EdgeInsets.only(right: 15.0),
            //                       alignment: Alignment.center,
            //                       decoration: BoxDecoration(
            //                           border: new Border.all(
            //                               color: selected == null
            //                                   ? Colors.transparent
            //                                   : selected == day
            //                                       ? selected ==
            //                                               DateTime.now().day
            //                                           ? Colors.transparent
            //                                           : Colors.grey
            //                                       : Colors.transparent),
            //                           color: day == DateTime.now().day
            //                               ? Colors.deepOrangeAccent
            //                               : Colors.grey.withOpacity(0.1),
            //                           borderRadius: BorderRadius.circular(5.0)),
            //                       child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: <Widget>[
            //                             Text(
            //                                 DateTime.now()
            //                                     .add(Duration(days: position))
            //                                     .day
            //                                     .toString(),
            //                                 style: TextStyle(
            //                                   fontSize: 25,
            //                                   fontWeight:
            //                                       day == DateTime.now().day
            //                                           ? FontWeight.bold
            //                                           : FontWeight.normal,
            //                                   color: day == DateTime.now().day
            //                                       ? Colors.white
            //                                       : Colors.grey[500],
            //                                 )),
            //                             Text(
            //                               DateFormat('EE').format(DateTime.now()
            //                                   .add(Duration(days: position))),
            //                               style: TextStyle(
            //                                   color: day == DateTime.now().day
            //                                       ? Colors.white
            //                                       : Colors.grey[700],
            //                                   fontWeight:
            //                                       day == DateTime.now().day
            //                                           ? FontWeight.bold
            //                                           : FontWeight.normal),
            //                             )
            //                           ]))),
            //               onTap: () {
            //                 setState(() {
            //                   selectDate = DateTime.now()
            //                       .add(Duration(days: position))
            //                       .day
            //                       .toString();
            //                   selectDay = DateFormat('EE').format(
            //                       DateTime.now().add(Duration(days: position)));

            //                   selected = DateTime.now().day + position;
            //                   print('Tag' + selected.toString());
            //                 });
            //               });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 25,
            ),

            Row(children: <Widget>[
              Expanded(
                  child: Divider(
                color: Colors.black45,
              )),
              Text(
                "  Laundry & Dry Cleaning  ",
                style: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              Expanded(
                  child: Divider(
                color: Colors.black45,
              )),
            ]),
            SizedBox(
              height: 10,
            ),

            Container(
              margin: EdgeInsets.all(5),
              height: 280,
              child: GridView.count(
                physics: ScrollPhysics(), //NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                mainAxisSpacing: 20,
                crossAxisSpacing: 8,
                crossAxisCount: 3,
                children: List.generate(allLaundry.length, (index) {
                  return Laundryy(
                    londry: allLaundry[index],
                    update: () {
                      setState(() {
                        print("oveerview");
                      });
                    },
                  );
                }),
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            // ListView.builder(itemBuilder: (ctx,index){
            //   return Container(
            //     child: Column(children: [
            //       Text(selectedLaundry[index].price),
            //       Text(selectedLaundry[index].title)
            //     ],),
            //   );
            // },itemCount: selectedLaundry.length,),

            // Container(
            //   height: 250,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: GridView(
            //       shrinkWrap: true,

            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 3,
            //           mainAxisSpacing: 15,
            //           crossAxisSpacing: 10),
            //       children: [

            //         InkWell(
            //           onTap: () {

            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Wash & Fold',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Rs.60/Kg',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Laundry',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Rs.90/Kg',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Premium Laundry',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Rs.140/Kg',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Express Laundry',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Rs.190/Kg',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Organic Wash',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Rs.130/Kg',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Woolen Wash',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Rs.130/Kg',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Curtain Wash',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Rs.130/Kg',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Ironing',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'See Details',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Dry Cleaning',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'See Details',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Premium Dry Cleaning',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'See Details',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Shoes, Bags & Leathers',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'See Details',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Household',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'See Details',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (builder) => Book()));
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: Border.all(color: Colors.black45)),
            //             child: Column(
            //               children: [
            //                 Spacer(),
            //                 Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: Text(
            //                       'Carpet Cleaning',
            //                       style: TextStyle(
            //                         color: Colors.deepPurple,
            //                         fontSize: 14,
            //                       ),
            //                     ))),
            //                 Spacer(),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Rs.22/sq.ft.',
            //                     style: TextStyle(
            //                       color: Colors.black45,
            //                       fontSize: 12,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Pickup and Delivery Charge (Rs 80) will be applicable for Item total less than Rs 450.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: <Widget>[
              Expanded(
                  child: Divider(
                color: Colors.black45,
              )),
              Text(
                "  In house Services  ",
                style: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              Expanded(
                  child: Divider(
                color: Colors.black45,
              )),
            ]),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10),
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (builder) => Book()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Spacer(),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  'Sanitization',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 14,
                                  ),
                                ))),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Rs.1/sq.ft.',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (builder) => Book()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Spacer(),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  'Pest Control',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 14,
                                  ),
                                ))),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Rs.1/sq.ft.',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (builder) => Book()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Spacer(),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  'Sofa Cleaning',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 14,
                                  ),
                                ))),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'See Details',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // TextButton(
            //     onPressed: () {
            //       opencheckout();
            //     },
            //     child: Text('BOOK'))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: () {
              //payment and db
              // if (selected == 0) {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text('Please select a Date'),
              //     duration: Duration(seconds: 2),
              //   ));
              // } else
              if (selectedLaundry.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please select a Service'),
                  duration: Duration(seconds: 2),
                ));
              } else if (count1 == false) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please select a Date'),
                  duration: Duration(seconds: 1),
                ));
              } else if (count2 == false) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please select a Time'),
                  duration: Duration(seconds: 1),
                ));
              } else {
                print('hellowww');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builer) => PaymentLaundry(
                              dateFix: dateFix,
                              timeFix: timeFix,
                              selectedDate:
                                  selectedDate.toString().substring(0, 11),
                              selectedLaundry: selectedLaundry,
                              selectedTime: selectedTime.format(context),
                              city: widget.city,

                            )));
              }
            },
            child: Text(
              'BOOK',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
