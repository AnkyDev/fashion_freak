import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/screens/jewellery/wishlist_screen.dart';
import 'package:fasion_freak_flutter/widgets/product.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';
class categoryscreen extends StatefulWidget {
  final List<productmodel> allproduct;
  String productid;
  categoryscreen({required this.productid , required this.allproduct});

  @override
  _categoryscreenState createState() => _categoryscreenState();
}

class _categoryscreenState extends State<categoryscreen> {

  List<productmodel> products = [];


  void initState() {
    print("checking products");
    filterProducts();
    super.initState();

  }

  void filterProducts() {
    print("checking product type");
    print(widget.allproduct.length.toString());
    if(widget.allproduct!=null) {
      print('notnull');
      widget.allproduct.forEach((element)  {
        print("111111");
        print(widget.productid.toString());
        if (element.productid.contains(widget.productid)) {
          products.add(element);
          print(products.length.toString());
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pop(context);
          },),
          title: Text("Fashion Freak",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => cartScreen()));
              },
              icon: Icon(Icons.shopping_cart_rounded),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => wishlist()));
              },
              icon: Icon(Icons.favorite_border),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            children: [

              SizedBox(width: 58,
              ),
              Text("Filter",
                style: TextStyle(
                    fontSize: 20
                ),),
              Expanded(child: IconButton(icon: Icon(Icons.filter_alt_outlined,size: 40,), onPressed: () {  },),),
              Text("Sort",
                style: TextStyle(
                    fontSize: 20
                ),),
              Expanded(child: IconButton(icon: Icon(Icons.sort,size: 40,), onPressed: () {  },),),

            ],
          ),
        ),
        body:Scaffold(
          body: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
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
        ),/* SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: 30,
                width: 400,
                color: Colors.red,
                child:Center(
                  child: Text("Necklace Sets",
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                ),
              ),*/
            /*  Card(
                child:Row(
                  children: [


                    Container(

                      height: 232,
                      width: 180,
                      color:Colors.white,
                      child: Column(
                        children: [
                          Card(
                            child: Image.asset(
                              'assets/unnamed.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),

                          Text("Golden Necklace",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            ),),


                          Text("Rs. 629",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),



                        ],
                      ),

                    ),
                    SizedBox(width: 20,),
                    Container(

                      height: 232,
                      width: 180,
                      color:Colors.white,
                      child: Column(
                        children: [
                          Card(
                            child: Image.asset(
                              'assets/necklace1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text("Golden Necklace",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            ),),
                          Text("Rs. 1629",
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
                child:Row(
                  children: [


                    Container(

                      height: 232,
                      width: 180,
                      color:Colors.white,
                      child: Column(
                        children: [
                          Card(
                            child: Image.asset(
                              'assets/necklace2.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text("Golden Necklace",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            ),),
                          Text("Rs. 1329",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),


                        ],
                      ),

                    ),
                    SizedBox(width: 20,),
                    Container(

                      height: 232,
                      width: 180,
                      color:Colors.white,
                      child: Column(
                        children: [
                          Card(
                            child: Image.asset(
                              'assets/necklace3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text("Golden Necklace",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            ),),
                          Text("Rs. 999",
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
                child:Row(
                  children: [


                    Container(

                      height: 232,
                      width: 180,
                      color:Colors.white,
                      child: Column(
                        children: [
                          Card(
                            child: Image.asset(
                              'assets/necklace4.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text("Golden Necklace",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            ),),
                          Text("Rs. 1799",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                        ],
                      ),

                    ),
                    SizedBox(width: 20,),
                    Container(

                      height: 232,
                      width: 180,
                      color:Colors.white,
                      child: Column(
                        children: [
                          Card(
                            child: Image.asset(
                              'assets/necklace5.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text("Golden Necklace",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            ),),
                          Text("Rs. 1999",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                        ],
                      ),

                    ),
                  ],
                ),
              ),
*/


    ));
  }
}
