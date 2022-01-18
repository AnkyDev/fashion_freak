import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/screens/jewellery/Productinfo_screen.dart';
import 'package:flutter/material.dart';
class product extends StatefulWidget {

  final productmodel Product;
  final Function update;
  const product({ required this.Product, required this.update});

  @override
  _productState createState() => _productState();
}

class _productState extends State<product> {

  List<productmodel> allproducts = [];
  List<productmodel> favouriteProds = [];

  Future<void> getAllProducts() async {
    allproducts = await Realtimedb.getAllProducts();
    setState(() {});
  }
  Future<void> getFav() async {
    favouriteProds = await Realtimedb.getwish();
    print(favouriteProds.length);
    favouriteProds.forEach((element) {
      element.isFavourite = true;
    });

    setState(() {});
  }

  Future<void> finalize() async {
    await getAllProducts();
    await getFav();

    allproducts.forEach((element) {
      favouriteProds.forEach((favelement) {
        if (favelement.title == element.title) {
          element.isFavourite = true;
        }
      });
    });
    setState(() {});
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalize();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => productinfo(product: widget.Product, allproduct: allproducts,update: () {
          setState(() {});
        })));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Image.network(
                      widget.Product.imgUrl,
                      height: 170,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
           SizedBox(height: 5,),
           // AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.Product.title,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
           // AppConstant.sizer(context: context, h: 0.01, w: 0.0),
              //  AppConstant.sizer(context: context, h: 0.0, w: 0.02),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                       "Rs." + widget.Product.price,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),


              //  AppConstant.sizer(context: context, h: 0.0, w: 0.03),

            //AppConstant.sizer(context: context, h: 0.01, w: 0.0),
     /*       Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    if (isFav) {
                      isFav = widget.product.isFavourite =
                      await RealtimeDatabase.removeFavfromdb(
                          productName: widget.product.productName);
                      snackBarText = "Removed from Favourites";
                    } else {
                      isFav = widget.product.isFavourite =
                      await RealtimeDatabase.addFavtodb(
                          product: widget.product);
                      snackBarText = "Added to Favourites";
                    }
                    setState(() {});
                    snackBar = SnackBar(
                      content: Text(
                        snackBarText,
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: AppColors.darkGreyColor,
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    widget.update();
                  },
                  child: Container(
                    padding: EdgeInsets.all(2),
                    // decoration: BoxDecoration(
                    //   color: AppColors.blackColor,
                    //   shape: BoxShape.circle,
                    // ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_outline,
                      color: AppColors.darkSlateGreyColor,
                    ),
                  ),
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.005),
                InkWell(
                  onTap: () async {
                    await RealtimeDatabase.addToKart(widget.product.productId);
                    SnackBar snackBar = SnackBar(
                      content: Text(
                        'Added to Kart.',
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Color.darkGreyColor,
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.darkSlateGreyColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_shopping_cart,
                          color: AppColors.darkGreyColor,
                        ),
                        Text(
                          "Add To Kart",
                          style: TextStyle(
                              color: AppColors.darkGreyColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),*/
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        //  color: AppColors.darkGreyColor,
          // boxShadow: [
          //   BoxShadow(
          //       color: AppColors.blackColor,
          //       blurRadius: 1,
          //       offset: Offset(0.9, 0.9),
          //       spreadRadius: 0.1)
          // ]
          border: Border.all(
            color: Colors.black
          )
        ),
      ),
    );
  }
}
