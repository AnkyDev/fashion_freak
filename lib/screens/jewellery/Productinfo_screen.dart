import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/screens/jewellery/cart_screen.dart';
import 'package:fasion_freak_flutter/screens/jewellery/wishlist_screen.dart';
import 'package:fasion_freak_flutter/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class productinfo extends StatefulWidget {
  final List<productmodel> allproduct;
  final productmodel product;
  final Function update;
  const productinfo(
      {required this.product, required this.allproduct, required this.update});

  @override
  _productinfoState createState() => _productinfoState();
}

class _productinfoState extends State<productinfo> {
  List<productmodel> products = [];
  List<productmodel> Wishlist = [];
  var rating = 3.0;
  late SnackBar snackBar;
  String snackBarText = "";
  late bool Wish = false;

  void filterProducts() {
    if (widget.allproduct != null) {
      widget.allproduct.forEach((element) {
        if (element.productid
            .contains(widget.product.productid[0].toString())) {
          products.add(element);
        }
      });
    }
  }

  Future<void> getWish() async {
    Wishlist = await Realtimedb.getwish();
    Wishlist.forEach((element) {
      element.isFavourite = true;
    });
    setState(() {});
  }

  Future<void> finalize() async {
    await getWish();
    Wishlist.forEach((favelement) {
      print(favelement.title);
      if (favelement.title == widget.product.title) {
        Wish = true;
        print(Wish.toString());
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalize();
    filterProducts();
    print(Wish.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Fashion Freak",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => cartScreen()));
              },
              icon: Icon(Icons.shopping_cart_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => wishlist()));
              },
              icon: Icon(Icons.favorite_border),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: Image.network(widget.product.imgUrl),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text(
                                    " " + widget.product.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () async {
                                  if (Wish) {
                                    Wish = widget.product.isFavourite =
                                        await Realtimedb.removewish(
                                            title: widget.product.title);
                                    snackBarText = "Removed from Favourites";
                                  } else {
                                    Wish = widget.product.isFavourite =
                                        await Realtimedb.addwish(
                                            product: widget.product);
                                    snackBarText = "Added to Favourites";
                                  }
                                  setState(() {});
                                  snackBar = SnackBar(
                                    content: Text(
                                      snackBarText,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: Colors.black,
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  widget.update();
                                },
                                icon: Icon(
                                  Wish
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              " Rs. " + widget.product.price,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 19,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // SmoothStarRating(
                    //   rating: rating,
                    //   isReadOnly: false,
                    //   size: 30,
                    //   filledIconData: Icons.star,
                    //   halfFilledIconData: Icons.star_half,
                    //   defaultIconData: Icons.star_border,
                    //   starCount: 5,
                    //   allowHalfRating: true,
                    //   spacing: 2.0,
                    //   onRated: (value) {
                    //     print("rating value -> $value");
                    //     // print("rating value dd -> ${value.truncate()}");
                    //   },
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Container(
                // color: Colors.yellow,
                width: 400,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(width: 50,),
                    Card(
                      child: FlatButton(
                        onPressed: () async {
                          await Realtimedb.addToCart(widget.product.productid);
                          await Realtimedb.totalprice(widget.product.price);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text('Item Added!'),duration: Duration(seconds: 1),),);
                          Fluttertoast.showToast(
                              msg: "Item Added",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1);
                        },
                        child: Text(
                          "Add to Cart",
                        ),
                        color: Colors.white,
                        minWidth: 185,
                      ),
                    ),
                    // SizedBox(width: 100,),
                    Card(
                      color: Colors.black,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => cartScreen()));
                        },
                        child: Text(
                          "Buy Now",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                        minWidth: 185,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "About The Product",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ExpansionTile(
                      title: Text(
                        "SPECIFICATION",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              // SizedBox(width: 120,),
                              Row(children: [
                                Expanded(
                                  child: Text(
                                    " Product Id",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    " : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    widget.product.productid,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ExpansionTile(
                        title: Text(
                          "SHIPPING",
                          style: TextStyle(color: Colors.black),
                        ),
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            child: Column(children: [
                              Text(
                                "           Once your order is packed and shipped , You will get Notification with your tracking information",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Text(
                                "          Order takes anywhere from 3 to 15 day to arrive depending on your local postal Service ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                            ]),
                          ),
                        ])
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ExpansionTile(
                        title: Text(
                          "PAYMENT",
                          style: TextStyle(color: Colors.black),
                        ),
                        children: [
                          Text(
                            "Cash on delivery is avaliable",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Net Banking and Card Payment is avaliable",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                        ]),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ExpansionTile(
                        title: Text(
                          "RETURNS",
                          style: TextStyle(color: Colors.black),
                        ),
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "7 days Return Policy",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ]),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                // height: 80,
                width: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Theme.of(context).hintColor.withOpacity(0.2),
                  //       spreadRadius: 2,
                  //       blurRadius: 5)
                  // ],
                ),
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        "View More Product",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Container(
                          height: 300,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                            height: 200,
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 0.71,
                              padding: EdgeInsets.all(10),
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              children: List.generate(products.length, (index) {
                                return product(
                                  Product: products[index],
                                  update: () {
                                    setState(() {});
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                        /* Card(
                          child: Row(
                            children: [
                              Container(

                                height: 242,
                                width: 160,
                                color:Colors.white,
                                child: Column(
                                  children: [
                                    Card(
                                      child: Image.asset(
                                        'asset/necklace5.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Text("Golden Necklace",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black
                                      ),),


                                    Text("Rs. 6788",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),



                                  ],
                                ),

                              ),
                              SizedBox(width: 20,),
                              Container(

                                height: 242,
                                width: 160,
                                color:Colors.white,
                                child: Column(
                                  children: [
                                    Card(
                                      child: Image.asset(
                                        'asset/necklace6.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text("Golden Necklace",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black
                                      ),),
                                    Text("Rs. 7659",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),


                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Row(
                            children: [
                              Container(

                                height: 242,
                                width: 160,
                                color:Colors.white,
                                child: Column(
                                  children: [
                                    Card(
                                      child: Image.asset(
                                        'asset/necklace7.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Text("Golden Necklace",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black
                                      ),),


                                    Text("Rs. 8768",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),



                                  ],
                                ),

                              ),
                              SizedBox(width: 20,),
                              Container(

                                height: 242,
                                width: 160,
                                color:Colors.white,
                                child: Column(
                                  children: [
                                    Card(
                                      child: Image.asset(
                                        'asset/necklace8.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text("Golden Necklace",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black
                                      ),),
                                    Text("Rs. 5489",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),


                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),*/
                      ],
                    )
                  ],
                ),
              ),
              Container(
                // height: 480,
                width: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Theme.of(context).hintColor.withOpacity(0.2),
                  //       spreadRadius: 2,
                  //       blurRadius: 5)
                  // ],
                ),
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        "You May Also Like",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Card(
                          child: Row(
                            children: [
                              Container(
                                height: 242,
                                width: 160,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Card(
                                      child: Image.asset(
                                        'asset/danglers.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Golden Necklace",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Rs. 629",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 242,
                                width: 160,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Card(
                                      child: Image.asset(
                                        'asset/unnamed.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Golden Necklace",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Rs. 1629",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Row(
                            children: [
                              Container(
                                height: 242,
                                width: 160,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Card(
                                      child: Image.asset(
                                        'asset/new.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Golden Necklace",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Rs. 629",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 242,
                                width: 160,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Card(
                                      child: Image.asset(
                                        'asset/new.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Golden Necklace",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Rs. 1629",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//  startTimer() {
//   const oneSec = const Duration(seconds: 1);
//   _timer = new Timer.periodic(
//     oneSec,
//         (Timer timer) => setState(
//           () {
//         if (seconds < 0) {
//           timer.cancel();
//         } else {
//           seconds = seconds + 1;
//           if (seconds > 59) {
//             minutes += 1;
//             seconds = 0;
//             if (minutes > 59) {
//               hours += 1;
//               minutes = 0;
//             }
//           }
//         }
//       },
//     ),
//   );

}
