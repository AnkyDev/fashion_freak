import 'dart:io';
import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/storageimages.dart';
import 'package:fasion_freak_flutter/screens/helper/addaccount_screen.dart';
import 'package:fasion_freak_flutter/screens/jewellery/order_screen.dart';
import 'package:fasion_freak_flutter/screens/laundry/order_screen_lon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

class ProfileLaundry extends StatefulWidget {
  const ProfileLaundry({Key? key}) : super(key: key);
  @override
  _ProfileLaundryState createState() => _ProfileLaundryState();
}

class _ProfileLaundryState extends State<ProfileLaundry> {
  FirebaseAuth fauth = FirebaseAuth.instance;
  late File _imageFile = File("");
  final ImagePicker _picker = ImagePicker();
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  late String name1 = '';
  late String address1 = '';
  late String imgUrl = '';
  String addresss = '';
  String username = '';
  Future<void> getAdrrreess() async {
    addresss = await Realtimedb.getAddress();
    print(addresss);
    setState(() {
      print('doneeee');
    });
  }

  Future<void> getUsernameEE() async {
    username = await Realtimedb.getUsername();

    setState(() {
      print('doneeee');
    });
  }

  Future<void> getinfo() async {
    DatabaseReference dbref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    dbref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('profiledetails');
    await dbref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        name1 = snapshot.value['name'].toString();
        address1 = snapshot.value['address'].toString();
      }
    });
    fetchimagefromfirebase();
  }

  fetchimagefromfirebase() async {
    final FirebaseUser currentUser = await fauth.currentUser();
    FireStorageService.loadFromStorage(context, _imageFile.toString())
        .then((downloadUrl) {
      imgUrl = downloadUrl.toString();
      setState(() {
        imgUrl = downloadUrl.toString();
      });
    });
    Realtimedb.saveinfo(currentUser.phoneNumber, name1, address1, imgUrl);
    print(imgUrl);
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
    // linkUrl: 'https://flutter.dev/',
    // chooserTitle: 'Example Chooser Title'
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAdrrreess();
    getUsernameEE();
    getinfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      tooltip: 'Share',
                      onPressed: share),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      username,
                      style: TextStyle(
                        fontSize: 25.0,
                        //letterSpacing: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: BottomSheetShape(),
                            backgroundColor: Colors.black,
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                //shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 10, color: Colors.black),
                                color: Colors.black),
                            child: Icon(
                              Icons.photo_camera_rounded,
                              color: Colors.white,
                            ))),
                    alignment: Alignment.bottomRight,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderScreenLondry()));
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 6.0,
                      margin: EdgeInsets.only(right: 15.0, left: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const ListTile(
                            leading: Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.black,
                            ),
                            title: Text(
                              'My Orders',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 6.0,
                    margin: EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.home_rounded,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Address',
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(addresss),
                        ),
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: TextButton.icon(
                              icon: Icon(Icons.add),
                              label: Text(
                                'Add Address',
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => addaccount()));
                              },
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(
                                              color: Colors.black)))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 95,
                  ),
                  new Container(
                    height: 50,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new TextButton.icon(
                          icon: Icon(Icons.delete_rounded),
                          label: new Text("Delete Account",
                              style: TextStyle(color: Colors.white)),
                          //color:  Colors.blueAccent[600],
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    body: Center(
                                      child: Text('accout delete'),
                                    ),
                                  ); /* CustomDialogBox(
                                    title: "Delete Account",
                                    descriptions: "Are you sure you want to delete your account?",
                                    text: "Yes",
                                  );*/
                                });
                          },
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        new TextButton.icon(
                          icon: Icon(Icons.logout),
                          label: new Text(
                            "Sign Out",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          //color:  Colors.blueAccent[600],
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      padding: EdgeInsets.only(top: 34, bottom: 16, left: 48, right: 48),
      height: 180,
      width: 200,
      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Choose your profile photo',
            style: TextStyle(fontSize: 23, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text(
                  'Camera',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source, imageQuality: 50);
    final FirebaseUser currentUser = await fauth.currentUser();
    //Realtimedb.saveinfo( currentUser.phoneNumber , name1 , address1  , image.toString());
    uploadImageToFirebase(context, image);
    setState(() {
      _imageFile = image;
    });
  }

  Future uploadImageToFirebase(BuildContext context, File img) async {
    //String fileName = img.path;
    final FirebaseUser currentUser = await fauth.currentUser();
    String uid = currentUser.uid.toString();
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('users/$uid');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(img);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String imgurl = taskSnapshot.ref.getDownloadURL().toString();

    // Realtimedb.saveinfo( currentUser.phoneNumber , name1 , address1  , imgurl);
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF000000);
    Path path = Path()
      ..relativeLineTo(0, 340)
      ..quadraticBezierTo(size.width / 2, 100.0, size.width, 340)
      ..relativeLineTo(0, -400)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BottomSheetShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();
/*
  @override
  Path getInnerPath(Rect rect, {required TextDirection textDirection}) {
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {required TextDirection textDirection}) {
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {required TextDirection textDirection}) {}*/

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 60);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getOuterPath
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }
}
