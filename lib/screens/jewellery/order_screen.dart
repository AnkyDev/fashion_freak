import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/order_model.dart';
import 'package:flutter/material.dart';

class orderscreen extends StatefulWidget {
  const orderscreen({Key? key}) : super(key: key);

  @override
  _orderscreenState createState() => _orderscreenState();
}

class _orderscreenState extends State<orderscreen> {
  List<ordermodel> orderproduct = [];

  Future<void> WishList() async {
    orderproduct = await Realtimedb.getAllorder().then((value) {
      setState(() {
        print('fetched');
      });
      return value;
    });
  }

  @override
  void initState() {
    WishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            //Grid view for cart products
            Container(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
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
                                      title: Text(orderproduct[index].title),
                                      content: //Row(
                                          //   children: [
                                          //     Text('Price -:'),
                                          //     Text(orderproduct[index].price),
                                          //   ],

                                          // ),
                                          ListTile(
                                        leading: Column(
                                          children: [
                                            Text('Price'),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text('Qty'),
                                          ],
                                        ),

                                        title: Container(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Text(orderproduct[index].price),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(orderproduct[index].qty),
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
                                  });
                            },
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      orderproduct[index].imgUrl,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 0),
                                        child: Text(
                                          orderproduct[index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 0),
                                        child: Text(
                                          "₹ " + orderproduct[index].price,
                                          // style: textStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 0),
                                        child: Text(
                                          "qty " + orderproduct[index].qty,
                                          // style: textStyle,
                                        ),
                                      ),
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
