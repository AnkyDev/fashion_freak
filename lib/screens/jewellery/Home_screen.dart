import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/Product_model.dart';
import 'package:fasion_freak_flutter/models/category_model.dart';
import 'package:fasion_freak_flutter/screens/jewellery/Profile_Section.dart';
import 'package:fasion_freak_flutter/screens/jewellery/wallet_screen.dart';
import 'package:fasion_freak_flutter/screens/jewellery/wishlist_screen.dart';
import 'package:fasion_freak_flutter/widgets/categories.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {


  int _selectedIndex = 0;
  static  List<Widget> _widgetOptions = <Widget>[
    First(),
    profilescreen(),
    cartScreen(),
    wishlist(),
    WalletScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_widgetOptions[_selectedIndex],
      /* Scaffold(
        body: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  icon: new Icon(Icons.search),
                  hintText: "Search",
                  filled:true,
                ),

              ),
              CarouselSlider(items: [

                /*Container(
                  child: Center(
                    child: Text("RakshaBandhan Special "
                        "30% Off",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          backgroundColor: Colors.black45,
                          color: Colors.white
                      ),),
                  ),

                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage("assets/offer.jpg"),
                    ),
                  ),

                ),

                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage("assets/image.jpg"),
                    ),
                  ),
                ),*/
                Image.network(carousel[0]),
                Image.network(carousel[1]),
                Image.network(carousel[2]),

              ],
                options: CarouselOptions(

                  height: 250.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  viewportFraction: 0.8,
                ),
              ),
              SizedBox(height: 30,),
              //trial db
              Container(
                height: 200,
                child: GridView.count(
                  padding: EdgeInsets.all(8),
                  crossAxisCount: 4,
                  children: List.generate(allcategory.length, (index) {
                    return categories(
                      category:allcategory[index],
                      update: () {
                        setState(() {
                          print("image calling");
                        });
                      },
                    );
                  }),
                ),
              ),

          /*    Container(
                child:Row(
                  children:[
                    SizedBox(width: 13,),
                    Card(
                      child:Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blueGrey,

                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/unnamed.jpg"),
                            ),
                          ),
                          Text("Necklace"),
                          Text("Sets")
                        ],
                      ),
                    ),

                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/new.jpg"),

                            ),
                          ),
                          Text("Bangles &"),
                          Text("Bracelets"),
                        ],
                      ),
                    ),
                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/new1.jpg"),

                            ),
                          ),
                          Text("Earrings"),
                          Text(" "),
                        ],
                      ),
                    ),
                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/anklets.jpg"),

                            ),
                          ),
                          Text("Anklets"),
                          Text(" "),
                        ],
                      ),
                    ),
                  ],
                  // ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child:Row(
                  children:[
                    SizedBox(width: 13,),
                    Card(
                      child:Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blueGrey,

                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/pendets.jpg"),
                            ),
                          ),
                          Text("Pendents"),
                          Text(" "),
                        ],
                      ),
                    ),

                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/rings.jpg"),

                            ),
                          ),
                          Text("Rings"),
                          Text(" "),
                        ],
                      ),
                    ),
                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/danglers.jpg"),

                            ),
                          ),
                          Text("Danglers"),
                          Text("Drops"),
                        ],
                      ),
                    ),
                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/mangalsutra.jpg"),

                            ),
                          ),
                          Text("mangalsutra"),
                          Text(" "),
                        ],
                      ),
                    ),
                  ],
                  // ),
                ),
              ),*/
              SizedBox(height: 90,),

           /*   Container(
                color:Colors.red,
                child:Row(
                  children:[
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.home,size: 40,),),

                    ),
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.person_pin,size: 40,),),

                    ),
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.shopping_cart_rounded,size: 40,),),

                    ),
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.notifications,size: 40,),),

                    ),
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.settings,size: 40,),),

                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),*/
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
           label: 'Profile',
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Wishlist',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
          backgroundColor: Colors.black,
        ),
      ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //


}

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {

  List<String> carousel = [];
  List<categoriesmodel> allcategory = [];
  List<productmodel> allproducts = [];
  List<String> image = [
    'assets/rings.jpg',
    'assets/rings.jpg',
    'assets/rings.jpg',
    'assets/rings.jpg',
    'assets/rings.jpg',
    'assets/rings.jpg',
  ];





  Future<void> getAllCategories() async {
    allcategory = await Realtimedb.getAllcategories();

  }

  Future<void> getAllProducts() async {
    allproducts = await Realtimedb.getAllProducts();
  }

  @override
  void initState(){
    super.initState();
    downloadImage();
    getAllCategories();
    getAllProducts();
   // print(allcategory.length.toString());
    print(allproducts.length.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 50,),
            CarouselSlider(
              items:carousel
                  .map(
                    (item) => Center(
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  .toList() ,


              options: CarouselOptions(

                height: 250.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                viewportFraction: 0.8,
              ),
            ),
            SizedBox(height: 30,),
            //trial db
            Container(
              margin: EdgeInsets.all(5),
              height: 280,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                mainAxisSpacing: 20,
                crossAxisCount: 4,
                children: List.generate(allcategory.length, (index) {
                  return categories(
                    category:allcategory[index],
                    update: () {
                      setState(() {
                        print("image calling");
                      });
                    },
                  );
                }),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),

            /*    Container(
                child:Row(
                  children:[
                    SizedBox(width: 13,),
                    Card(
                      child:Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blueGrey,

                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/unnamed.jpg"),
                            ),
                          ),
                          Text("Necklace"),
                          Text("Sets")
                        ],
                      ),
                    ),

                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/new.jpg"),

                            ),
                          ),
                          Text("Bangles &"),
                          Text("Bracelets"),
                        ],
                      ),
                    ),
                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/new1.jpg"),

                            ),
                          ),
                          Text("Earrings"),
                          Text(" "),
                        ],
                      ),
                    ),
                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/anklets.jpg"),

                            ),
                          ),
                          Text("Anklets"),
                          Text(" "),
                        ],
                      ),
                    ),
                  ],
                  // ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child:Row(
                  children:[
                    SizedBox(width: 13,),
                    Card(
                      child:Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blueGrey,

                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/pendets.jpg"),
                            ),
                          ),
                          Text("Pendents"),
                          Text(" "),
                        ],
                      ),
                    ),

                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/rings.jpg"),

                            ),
                          ),
                          Text("Rings"),
                          Text(" "),
                        ],
                      ),
                    ),
                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/danglers.jpg"),

                            ),
                          ),
                          Text("Danglers"),
                          Text("Drops"),
                        ],
                      ),
                    ),
                    SizedBox(width : 7,),
                    Card(
                      child: Column(
                        children:[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/mangalsutra.jpg"),

                            ),
                          ),
                          Text("mangalsutra"),
                          Text(" "),
                        ],
                      ),
                    ),
                  ],
                  // ),
                ),
              ),*/
            SizedBox(height: 20,),
            Center(
              child: Text('Girl must own'),
            ),
            Container(
              height: 700,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap : true,
                crossAxisCount: 2,
                  mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children:List.generate(image.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    image:  new DecorationImage(
                      image: ExactAssetImage(image[index]),
                      fit: BoxFit.fitHeight,
                    ),
                  ),),
                );
              }),),
            )
            /*   Container(
                color:Colors.red,
                child:Row(
                  children:[
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.home,size: 40,),),

                    ),
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.person_pin,size: 40,),),

                    ),
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.shopping_cart_rounded,size: 40,),),

                    ),
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.notifications,size: 40,),),

                    ),
                    SizedBox(width: 16,),
                    Card(
                      color: Colors.red,
                      child:IconButton(onPressed: () {  }, icon: Icon(Icons.settings,size: 40,),),

                    ),
                  ],
                ),
              ),*/
          ],
        ),
      ),
    );
  }
  Future  downloadImage()async{
    for( int i =1 ;i<4 ;i++){
      StorageReference _reference=FirebaseStorage.instance.ref().child("carousel/j$i.jpg");
      String downloadAddress=await _reference.getDownloadURL();
       carousel.add(downloadAddress);
       print('carousel[$i] : ',);
      print(downloadAddress);
      setState(() {
        //_downloadUrl=downloadAddress;
      });
    }

  }
} 

