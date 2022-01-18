import 'package:fasion_freak_flutter/db/db.dart';
import 'package:fasion_freak_flutter/models/Prefs.dart';
import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/models/UserModel.dart';
import 'package:fasion_freak_flutter/models/address_model.dart';
import 'package:fasion_freak_flutter/models/category_model.dart';
import 'package:fasion_freak_flutter/models/laundry_model.dart';
import 'package:fasion_freak_flutter/models/order_model.dart';
import 'package:fasion_freak_flutter/models/order_model_lon.dart';
import 'package:fasion_freak_flutter/models/voucher_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Realtimedb {
  static late AppUser user;
  static Future<void> getUser() async {
    user = await Prefs.getUser();
  }

  static Future<List<categoriesmodel>> getAllcategories() async {
    DatabaseReference dbref;
    final List<categoriesmodel> allcategory = [];
    Map<dynamic, dynamic> category;
    dbref = FirebaseDatabase.instance.reference().child('categories');

    await dbref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        category = snapshot.value as Map;
        List<categoriesmodel> temp = [];
        temp = await getEachCategory(category);
        allcategory.addAll(temp);
        print(allcategory);
      }
    });
    return allcategory;
  }

  static Future<List<categoriesmodel>> getEachCategory(
      Map<dynamic, dynamic> testMap) async {
    List<categoriesmodel> productList = [];
    testMap.forEach((key, value) {
      productList.add(categoriesmodel(
        id: value['id'] ?? "",
        title: value['title'] ?? "",
        imgUrl: value['imgUrl'] ?? "",
        productid: value['productid'] ?? "",
      ));
    });
    return productList;
  }

  //products
  static Future<List<productmodel>> getAllProducts() async {
    DatabaseReference dbref;
    final List<productmodel> allProducts = [];
    Map<dynamic, dynamic> prodcat;
    dbref = FirebaseDatabase.instance.reference().child('products');

    await dbref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        prodcat = snapshot.value as Map;
        prodcat.values.forEach((element) async {
          List<productmodel> temp = [];
          temp = await getEachProductData(element as Map);
          allProducts.addAll(temp);
          print(allProducts);
        });
      }
    });
    return allProducts;
  }

  static Future<List<productmodel>> getEachProductData(
      Map<dynamic, dynamic> testMap) async {
    List<productmodel> productList = [];
    testMap.forEach((key, value) {
      productList.add(productmodel(
        productid: value['productid'] ?? "",
        price: value['price'] ?? "",
        title: value['title'] ?? "",
        imgUrl: value['imgUrl'] ?? "",
      ));
    });
    return productList;
  }

  //get cart list
  static Future<Map<dynamic, dynamic>> getKartList() async {
    await getUser();
    DatabaseReference kartRef;
    Map<dynamic, dynamic> kartMap = {};
    kartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart");
    print(user.uid);
    await kartRef.once().then((DataSnapshot snapshot) {
      if (snapshot != null) {
        kartMap = snapshot.value as Map;
      }
    });

    return kartMap;
  }

  //add to cart
  static Future<void> addToCart(String productid) async {
    await getUser();
    DatabaseReference kartRef;

    Map<dynamic, dynamic> kart = {};
    List<dynamic> kartProdList = [];
    Map<String, dynamic> initialKart = {};
    kartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart");
    await kartRef.once().then((DataSnapshot snapshot) {
      if (snapshot != null) {
        kart = snapshot.value;
        if (kart != null) {
          kartProdList = kart.keys.toList();
        } else {
          initialKart = {'$productid': "1"};
          kartRef.update(initialKart);
        }
      }
    });
    int len = 0;
    if (kartProdList.contains(productid)) {
      len = int.parse(kart[productid].toString());
      len++;
      await kartRef.update({'$productid': '$len'});
    } else {
      await kartRef.update({'$productid': '1'});
    }
    if (len == 0) {}
  }

  //delete product from cart
  static Future<void> deleteFromCart(
      String productid, String price, String qty) async {
    await getUser();
    DatabaseReference CartRef;
    CartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart");
    CartRef.child(productid).remove();

    // delete price from total price

    late String preprice;
    //
    DatabaseReference dbref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    dbref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart")
        .child('totalprice');
    await dbref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        preprice = snapshot.value['totalprice'].toString();
      }
    });

    String Price = price;
    int value = int.parse(preprice) - (int.parse(Price) * int.parse(qty));
    print(preprice);
    print(value);

    CartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart")
        .child('totalprice');
    CartRef.update({'totalprice': value});
  }

  //save userinfo
  static Future<void> saveinfo(
      String num, String name, String address, String profileUrl) async {
    await getUser();
    DatabaseReference numref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    numref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${currentUser.uid}/profiledetails');
    numref.set({
      'number': num,
      'name': name,
      'address': address,
      'ProfileUrl': profileUrl
    });
  }

  //total price
  static Future<void> totalprice(String price) async {
    late String preprice;
    //
    DatabaseReference dbref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    dbref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart")
        .child('totalprice');
    await dbref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        preprice = snapshot.value['totalprice'].toString();
      } else
        dbref.set({'totalprice': price});
    });

    await getUser();
    DatabaseReference CartRef;

    String Price = price;
    int value = int.parse(preprice) + int.parse(Price);
    print(preprice);

    Map<dynamic, dynamic> kart = {};
    List<dynamic> kartProdList = [];
    Map<String, dynamic> initialKart = {};
    CartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart")
        .child('totalprice');
    CartRef.update({'totalprice': value});
  }

  //add to wishlist
  // to add product in favourite list of user in database
  static Future<bool> addwish({required productmodel product}) async {
    await getUser();
    final favRef = FirebaseDatabase.instance
        .reference()
        .child('users/${user.uid}/WishList/');
    Map<String, dynamic> favProduct = {
      "${product.title}": {
        'title': product.title,
        'imgUrl': product.imgUrl,
        'price': product.price,
        'productid': product.productid,
      }
    };
    if (user.uid != null) {
      favRef.update(favProduct);
      return true;
    } else {
      print("uid is null");
      return false;
    }
  }

  //to remove given item from favourite list form database
  static Future<bool> removewish({required String title}) async {
    await getUser();
    final favRef = FirebaseDatabase.instance
        .reference()
        .child('users/${user.uid}/WishList/');
    await favRef.child(title).remove();
    return false;
  }

  // to get current users favourite product list
  static Future<List<productmodel>> getwish() async {
    await getUser();
    DatabaseReference favref;
    List<productmodel> favproducts = [];
    favref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child('WishList');
    await favref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        List<productmodel> temp = [];
        temp = await getEachProductData(snapshot.value as Map);
        favproducts.addAll(temp);
      }
    });
    return favproducts;
  }

  //delete the cart
  static Future<void> deleteCart() async {
    await getUser();
    DatabaseReference CartRef;
    CartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}');
    print("calling");
    CartRef.child('Cart').remove();
  }

  //history
  static Future<void> addToOrder(productmodel product, String qty,
      String paymenttype, String date, String time) async {
    await getUser();
    DatabaseReference kartRef;
    kartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Order");
    // .child(date)
    // .child(time);
    Map<String, dynamic> favProduct = {
      "${date} ${time} ${product.title}": {
        'title': product.title,
        'imgUrl': product.imgUrl,
        'price': product.price,
        'payment': paymenttype,
        'qty': qty,
        'productid': product.productid,
      }
    };
    if (user.uid != null) {
      kartRef.update(favProduct);
    } else {
      print("uid is null");
    }
  }

  static Future<List<vouchermodel>> getAllvoucher() async {
    DatabaseReference dbref;
    final List<vouchermodel> allvoucher = [];
    Map<dynamic, dynamic> voucher;
    dbref = FirebaseDatabase.instance.reference().child('voucher');

    await dbref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        voucher = snapshot.value as Map;
        List<vouchermodel> temp = [];
        temp = await getEachvoucher(voucher);
        allvoucher.addAll(temp);
        print(allvoucher);
      }
    });
    return allvoucher;
  }

  static Future<List<vouchermodel>> getEachvoucher(
      Map<dynamic, dynamic> testMap) async {
    print("voucher calling");
    List<vouchermodel> voucherList = [];
    testMap.forEach((key, value) {
      voucherList.add(vouchermodel(
        vouchername: value['voucher_Name'] ?? "",
        amount: value['voucher_amt'] ?? "",
        id: value['voucher_id'] ?? "",
      ));
    });
    return voucherList;
  }

  //apply voucher
  static Future<void> applyvoucher(String price, String voucher) async {
    late String preprice;
    //
    DatabaseReference dbref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    dbref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart")
        .child('totalprice');
    await dbref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        preprice = snapshot.value['totalprice'].toString();
      } else
        dbref.set({'totalprice': price});
    });

    await getUser();
    DatabaseReference CartRef;

    String Price = price;
    int value = int.parse(preprice) - int.parse(Price);
    print(preprice);

    Map<dynamic, dynamic> kart = {};
    List<dynamic> kartProdList = [];
    Map<String, dynamic> initialKart = {};
    CartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Cart")
        .child('totalprice');
    CartRef.update({'totalprice': value});
    CartRef.update(({'voucher': voucher}));
  }

  //get orders
  static Future<List<ordermodel>> getAllorder() async {
    await getUser();
    DatabaseReference dbref;
    final List<ordermodel> allorder = [];
    Map<dynamic, dynamic> prodcat;

    dbref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("Order");

    await dbref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        prodcat = snapshot.value as Map;
        List<ordermodel> temp = [];
        temp = await getorder1(snapshot.value as Map);
        allorder.addAll(temp);
        // prodcat.values.forEach((element) async {
        //
        //   temp = await getorder1(element as Map);
        //   allorder.addAll(temp);
        //   print(allorder);
        // });
      }
    });
    return allorder;
  }

  static Future<List<ordermodel>> getorder1(
      Map<dynamic, dynamic> testMap) async {
    List<ordermodel> orderList = [];
    testMap.forEach((key, value) {
      orderList.add(ordermodel(
        id: value['id'] ?? "ib",
        title: value['title'] ?? "y",
        imgUrl: value['imgUrl'] ?? "j",
        price: value['price'] ?? "jj",
        paymentmode: value['imgUrl'] ?? "jj",
        qty: value['qty'] ?? "jj",
      ));
    });
    return orderList;
  }

  static Future<List<LaundryModel>> getLaundryDetails() async {
    DatabaseReference lanref;
    List<LaundryModel> laundryList = [];
    lanref = FirebaseDatabase.instance
        .reference()
        .child('laundry_services')
        .child('dry cleaning');
    await lanref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        print(snapshot.value);
        print('inside of laundryDetails');
        print(snapshot.value);
        List<LaundryModel> temp = [];
        temp = await getEachLaundryData(snapshot.value as Map);
        print(temp.length);
        print('just wondering');
        laundryList.addAll(temp);
        print(laundryList.length);
      }
    });
    return laundryList;
  }

  static Future<List<LaundryModel>> getEachLaundryData(
      Map<dynamic, dynamic> testMap) async {
    List<LaundryModel> laundryList = [];
    testMap.forEach((key, value) {
      print('hello ');
      laundryList.add(LaundryModel(
        price: value['price'] ?? "hi",
        title: value['title'] ?? "hi",
      ));
    });
    return laundryList;
  }

  static Future<void> addToOrderLaundry(LaundryModel londry, String paymenttype,
      String date, String dateBuy, String orderId, String timeBuy,String city) async {
    await getUser();
    DatabaseReference lonRef;
    lonRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("OrderLaundry");
    // .child(dateBuy)
    // .child(timeBuy);

    Map<String, dynamic> lonOrder = {
      "${dateBuy} ${timeBuy} ${londry.title}": {
        'title': londry.title,
        'price': londry.price,
        'payment': paymenttype,
        'date': date,
        'orderId': orderId,
        'dateBuy': dateBuy,
        'timeBuy': timeBuy,
        'city':city,
      }
    };
    if (user.uid != null) {
      lonRef.update(lonOrder);
    } else {
      print("uid is null");
    }
    print("order placed for laundry");
  }

  static Future<List<OrderModelLondry>> getAllorderLaundry() async {
    DatabaseReference dbref;
    List<OrderModelLondry> allorder = [];
    await getUser();
    Map<dynamic, dynamic> prodcat;
    print('working part 1');
    print('${user.uid}');

    dbref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child('OrderLaundry');

    await dbref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        print(snapshot.value);
        print('inside of getAllorderLaundry');
        List<OrderModelLondry> temp = [];
        temp = await getAllorderLaundry2(snapshot.value as Map);
        print(temp.length);
        print('just wondering2');
        allorder.addAll(temp);
        print(allorder.length);

        // prodcat = snapshot.value as Map;
        // print(prodcat);
        // prodcat.values.forEach((element) async {
        //   List<OrderModelLondry> temp;
        //   temp = await getAllorderLaundry2(element as Map);
        //   allorder.addAll(temp);
        //   print(allorder);
        // });
      }
    });
    return allorder;
  }
  /* 
  if (snapshot.value != null) {
        print(snapshot.value);
        print('inside of laundryDetails');
        print(snapshot.value);
        List<LaundryModel> temp = [];
        temp = await getEachLaundryData(snapshot.value as Map);
        print(temp.length);
        print('just wondering');
        laundryList.addAll(temp);
        print(laundryList.length);
      }
    });
    return laundryList;
  */

  static Future<List<OrderModelLondry>> getAllorderLaundry2(
      Map<dynamic, dynamic> testMap) async {
    List<OrderModelLondry> orderList = [];
    testMap.forEach((key, value) {
      print('world');
      orderList.add(OrderModelLondry(
        date: value['date'] ?? "hi",
        payment: value['payment'] ?? "hi",
        price: value['price'] ?? "hi",
        title: value['title'] ?? "hi",
        timeBuy: value['timeBuy'] ?? "hi",
        dateBuy: value['datebuy'] ?? "hi",
        city:value['city']??"ji",
      )
          //   ordermodel(
          //   id: value['id'] ?? "",
          //   title: value['title'] ?? "",
          //   imgUrl: value['imgUrl'] ?? "",
          //   price: value['price'] ?? "",
          //   paymentmode: value['imgUrl'] ?? "",
          //   qty: value['qty'] ?? "",
          // )
          );
    });
    return orderList;
  }

  static Future<String> getUsername() async {
    String username='';
    await getUser();
    DatabaseReference numref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    numref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("profiledetails");
    await numref.once().then((DataSnapshot snapshot) {
      //
      if (snapshot.value != null) {
        username = snapshot.value['name'];
        // address = '21331';

      } else {
        username = 'hello12345';
      }
    });
    return username.toString();
  }

  static Future<String> getAddress() async {
    AddressModel addressModel;
    String address = '1234556';
    await getUser();
    DatabaseReference numref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    numref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("profiledetails");
    // address=
    print(user.uid);
    await numref.once().then((DataSnapshot snapshot) {
      //
      if (snapshot.value != null) {
        address = snapshot.value['address'];
        // address = '21331';
        print(address);
      } else {
        address = 'hello12345';
      }
    });

    // address = '324';
    print('124');

    print(address);
    return address.toString();
  }
  /**
    static Future<List<LaundryModel>> getLaundryDetails() async {
    DatabaseReference lanref;
    List<LaundryModel> laundryList = [];
    lanref = FirebaseDatabase.instance
        .reference()
        .child('laundry_services')
        .child('dry cleaning');
    await lanref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        print(snapshot.value);
        print('inside of laundryDetails');
        print(snapshot.value);
        List<LaundryModel> temp = [];
        temp = await getEachLaundryData(snapshot.value as Map);
        print(temp.length);
        print('just wondering');
        laundryList.addAll(temp);
        print(laundryList.length);
      }
    });
    return laundryList;
  }

  static Future<List<LaundryModel>> getEachLaundryData(
      Map<dynamic, dynamic> testMap) async {
    List<LaundryModel> laundryList = [];
    testMap.forEach((key, value) {
      print('hello ');
      laundryList.add(LaundryModel(
        price: value['price'] ?? "hi",
        title: value['title'] ?? "hi",
      ));
    });
    return laundryList;
  }


  */
}
