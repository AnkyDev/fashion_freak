// import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
// import 'package:fasion_freak_flutter/models/Product_model.dart';
// import 'package:fasion_freak_flutter/screens/jewellery/cart_screen.dart';
// import 'package:flutter/material.dart';

// class CartListviewScreen extends StatefulWidget {
  
  

//   @override
//   _CartListviewScreenState createState() => _CartListviewScreenState();
// }

// class _CartListviewScreenState extends State<CartListviewScreen> {
//   List<productmodel> allgudProducts=[];
//   List<productmodel> allproducts = [];
//   Map<dynamic, dynamic> CartMap = {};
//   List<dynamic> qty = [];
//   bool noItems = false;

//   Future<void> getAllProducts() async {
//     allproducts = await Realtimedb.getAllProducts();
//     setState(() {});
//   }


//   Future<void> getCartList() async {
//     CartMap = await Realtimedb.getKartList();
//     setState(() {});
//   }
//   Future<void> finalize() async {
//     setState(() {
//      // isLoading = true;
//     });
//     await getAllProducts();
//     await getCartList();


//     if (CartMap == null) {
//       setState(() {
//         noItems = true;
//       });
//     } else {
//       qty = CartMap.values.toList();
//       CartMap.keys.forEach((CartElement) {
//         allproducts.forEach((element) {
//           if (element.productid == CartElement) {
//             allgudProducts.add(element);
//           }
//         });
//       });
//     }
//     setState(() {
//       //isLoading = false;
//     });
//   }
//   @override
//   void initState() {
//     finalize();
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: allgudProducts.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: Container(
//               height: 100,
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black,
//                         blurRadius: 1,
//                         offset: Offset(0.9, 0.9),
//                         spreadRadius: 0.1)
//                   ]),
//               child: Row(
//                 children: [
//                   Container(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         allgudProducts[index].imgUrl,
//                         height: 80,
//                         width: 80,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
//                           child: Text(
//                             allgudProducts[index].title,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
//                           child: Text(
//                             "₹ " + allgudProducts[index].price,
//                             // style: textStyle,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
//                           child: Text(
//                             "Qty : " + '1' //qty[index].toString()
//                             ,
//                             // style: textStyle,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: IconButton(
//                         onPressed: () async {
//                           await Realtimedb.deleteFromCart(
//                             allgudProducts[index].productid,
//                             allgudProducts[index].price,
//                             '1', //qty[index].toString()
//                           );

//                           await getCartList();
//                           if (CartMap == null) {
//                             setState(() {
//                               noItems = true;
//                             });
//                           }
//                           allgudProducts.removeWhere((element) =>
//                               element.productid ==
//                               allgudProducts[index].productid);
//                           // cartScreen().CartProducts.removeWhere((element) =>
//                           //     element.productid ==
//                           //     allgudProducts[index].productid);
//                         },
//                         icon: Icon(Icons.delete),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
