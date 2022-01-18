import 'package:fasion_freak_flutter/screens/phoneauth_screen.dart';
import 'package:flutter/material.dart';
class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 300,
                          child: Image(image: AssetImage('assets/fashionfreak.jpg'))),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Get ready to make your life easy with a single click of app, which makes laundry things handle better.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextButton(
                          child: Text(
                            "Sign In".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          style: ButtonStyle(
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(20)),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffffcc00)),
                          ),
                          onPressed: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) => phoneauth());
                          })
                    ])),
          ),
        ));
  }
}
