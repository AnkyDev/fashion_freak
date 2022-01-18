import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/order_model_lon.dart';
import 'package:flutter/material.dart';

class OrderScreenLondry extends StatefulWidget {
  const OrderScreenLondry({Key? key}) : super(key: key);

  @override
  _OrderScreenLondryState createState() => _OrderScreenLondryState();
}

class _OrderScreenLondryState extends State<OrderScreenLondry> {
  List<OrderModelLondry> orderproduct = [];

  Future<void> WishList() async {
    orderproduct = await Realtimedb.getAllorderLaundry().then((value) {
      setState(() {
        // print('done');
      });
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    WishList();
    print(orderproduct.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: Colors.green,
      ),
      body: orderproduct.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //Grid view for cart products
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orderproduct.length,
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
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // return object of type Dialog
                                        return AlertDialog(
                                          title:
                                              Text(orderproduct[index].title),
                                          content: ListTile(
                                            // leading: Container(
                                            //   child: Column(
                                            //     mainAxisSize: MainAxisSize.min,
                                            //     children: [
                                            //       Text('Price'),
                                            //       Text('Date'),
                                            //       Text('Time'),
                                            //       Text('City')
                                            //     ],
                                            //   ),
                                            // ),
                                            title: Container(
                                              // height: 50,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('Price : '),
                                                      SizedBox(
                                                        width: 90 ,
                                                      ),
                                                      Text(orderproduct[index]
                                                          .price),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('Date : '),
                                                      SizedBox(
                                                        width: 35,
                                                      ),
                                                      Text(orderproduct[index]
                                                          .date),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('Time : '),
                                                      SizedBox(
                                                        width: 80,
                                                      ),
                                                      Text(orderproduct[index]
                                                          .timeBuy),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('City : '),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Text(orderproduct[index]
                                                          .city),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //subtitle: Text('hello'),
                                          ),
                                          actions: <Widget>[
                                            // usually buttons at the bottom of the dialog
                                            new FlatButton(
                                              child: new Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Icon(
                                        Icons.arrow_circle_up_rounded,
                                        size: 40,
                                      )),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 0, 0),
                                                  child: Text(
                                                    'Booked',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 15, 0),
                                                  child: Text(
                                                    orderproduct[index].date,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 0, 0),
                                                  child: Text(
                                                    orderproduct[index].title,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 15, 0),
                                                  child: Text(
                                                    "₹ " +
                                                        orderproduct[index]
                                                            .price,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
