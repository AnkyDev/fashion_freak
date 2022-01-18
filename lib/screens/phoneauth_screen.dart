import 'dart:async';
import 'package:fasion_freak_flutter/db/db.dart';
import 'package:fasion_freak_flutter/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class phoneauth extends StatefulWidget {
  const phoneauth({Key? key}) : super(key: key);
  @override
  _phoneauthState createState() => _phoneauthState();
}

class _phoneauthState extends State<phoneauth> {
  @override
    int start = 30;
    bool wait = false;
    String buttonName = "Send";
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    //db dbref = db();

    @override
    Widget build(BuildContext context) {
      final auth1 = Provider.of<db>(context);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Sign Up",
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
                    height: 30,
                  ),
                  textField1(),
                  SizedBox(
                    height: 20,
                  ),
                  textField(),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () {
                      String Num = phoneController.text.trim();
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) => otpscreen(num: Num,name :nameController.text.trim()));
                          auth1.verifyPhoneNumber(context,Num);
                    },
                    child: Text(
                      "Send OTP".toUpperCase(),
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
            wait = false;
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
          controller: phoneController,
          style: TextStyle(color: Color(0xff030303), fontSize: 17),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your phone Number",
            hintStyle: TextStyle(color: Color(0xff000000), fontSize: 17),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                " (+91) ",
                style: TextStyle(color: Color(0xff0c0c0c), fontSize: 17),
              ),
            ),
          ),
        ),
      );
    }

    Widget textField1() {
      //final auth = Provider.of<AuthProvider>(context);
      return Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: nameController,
          style: TextStyle(color: Color(0xff000000), fontSize: 17),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your name",
            hintStyle: TextStyle(color: Color(0xff000000), fontSize: 17),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                "",
                style: TextStyle(color: Color(0xff0a0a0a), fontSize: 17),
              ),
            ),
          ),
        ),
      );
    }
  }
