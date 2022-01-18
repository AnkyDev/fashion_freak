import 'dart:async';

import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/db/db.dart';
import 'package:fasion_freak_flutter/models/Prefs.dart';
import 'package:fasion_freak_flutter/screens/option.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class otpscreen extends StatefulWidget {
  late String num;
  late String name;

  otpscreen({required this.num,required this.name});

  @override
  _otpscreenState createState() => _otpscreenState();
}

class _otpscreenState extends State<otpscreen> {

  FirebaseAuth fauth = FirebaseAuth.instance;

  late String verificationId;
  String address ="";
  String profileUrl ="";
  //db dbref = db();


  TextEditingController otpController = TextEditingController();
  int start = 30;
  @override
  Widget build(BuildContext context) {
    final auth1 = Provider.of<db>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Sign In",
          style: TextStyle(color: Color(0xff000000), fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 80,
                ),
                textField(),
                SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () async{

                    try {
                      print(auth1.verificationId.toString());
                      AuthResult cred = await fauth
                          .signInWithCredential(PhoneAuthProvider.getCredential(verificationId: auth1.verificationId, smsCode: otpController.text));
                      if (cred.user != null) {
                        final FirebaseUser currentUser = await fauth.currentUser();
                        //String uid = currentUser.uid.toString();
                        Prefs.setUser(currentUser);
                        //print(uid);
                       // print(currentUser.phoneNumber);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => option()),
                                (route) => false);
                        //print(widget.name);
                        Realtimedb.saveinfo(widget.num , widget.name , address , profileUrl);
                      }

                    } catch (e) {
                      print(e.toString());
                      SnackBar snackBar = SnackBar(content: Text('Invalid OTP'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    //auth.verifyPhoneNumber(context,);
                  },
                  child: Text(
                    "Verify".toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xffffcc00)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          //wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget textField() {
    //final auth = Provider.of<AuthProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: otpController,
        //controller: phoneController,
        style: TextStyle(color: Color(0xff000000), fontSize: 17),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your Otp",
          hintStyle: TextStyle(color: Color(0xff000000), fontSize: 17),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              "",
              style: TextStyle(color: Color(0xff000000), fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
