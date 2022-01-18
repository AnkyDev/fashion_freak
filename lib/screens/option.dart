import 'package:fasion_freak_flutter/screens/jewellery/Home_screen.dart';
import 'package:fasion_freak_flutter/screens/laundry/bottom_nav.dart';
import 'package:fasion_freak_flutter/screens/laundry/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class option extends StatefulWidget {
  const option({Key? key}) : super(key: key);

  @override
  _optionState createState() => _optionState();
}

class _optionState extends State<option> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (ctx) => BottomNavHomeScreen()));
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    image: new DecorationImage(
                      image: ExactAssetImage('assets/laundry.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Homescreen()));
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    image: new DecorationImage(
                      image: ExactAssetImage('assets/jewellery.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
