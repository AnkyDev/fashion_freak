import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/models/category_model.dart';
import 'package:fasion_freak_flutter/screens/jewellery/category_screen.dart';
import 'package:flutter/material.dart';

class categories extends StatefulWidget {
  final categoriesmodel category;
  final Function update;
  categories({required this.category, required this.update});

  @override
  _categoriesState createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  List<productmodel> allproducts = [];

  Future<void> getAllProducts() async {
    print("product calling");
    allproducts = await Realtimedb.getAllProducts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => categoryscreen(
                      productid: widget.category.productid,
                      allproduct: allproducts,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          height: 300,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  child: Image.network(
                    widget.category.imgUrl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(widget.category.title),
            ],
          ),
        ),
      ),
    );
  }
}
