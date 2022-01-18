import 'dart:async';

import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/screens/jewellery/Productinfo_screen.dart';
import 'package:flutter/material.dart';
class wishlist extends StatefulWidget {
  const wishlist({Key? key}) : super(key: key);

  @override
  _wishlistState createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {

  List<productmodel> WishProducts = [];
  List<dynamic> qty = [];
  List<productmodel> allproducts = [];
  bool deleteItem = false;
  bool noItems = false;

  Future<void> getAllProducts() async {
    allproducts = await Realtimedb.getAllProducts();
    setState(() {});
  }


  Future<void> WishList() async {
    WishProducts = await Realtimedb.getwish();
    setState(() {});
  }


  @override
  void initState() {
    //WishList();
    getAllProducts();
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => WishList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Grid view for cart products
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: WishProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    offset: Offset(0.9, 0.9),
                                    spreadRadius: 0.1)
                              ]
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => productinfo(product: WishProducts[index], allproduct: allproducts,update: () {
                                setState(() {});
                              })));
                            },
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: Image.network(
                                      WishProducts[index].imgUrl,
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
                                        padding: const EdgeInsets.fromLTRB(8,0,0,0),
                                        child: Text(
                                          WishProducts[index].title,
                                          style:TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8,0,0,0),
                                        child: Text(
                                          "₹ " + WishProducts[index].price,
                                          // style: textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: IconButton(onPressed: () async {
                                       //await WishList();
                                      /*if (WishProducts == null) {
                                        setState(() {
                                          noItems = true;
                                        });
                                      }*/
                                      await Realtimedb.removewish(title:WishProducts[index].title);
                                      WishProducts.removeWhere(
                                              (element) =>
                                          element.productid ==
                                              WishProducts[index]
                                                  .productid);
                                    }, icon:Icon(Icons.delete),),
                                  ),
                                )
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
