import 'package:flutter/material.dart';
class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Your Profile",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800
          ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 160,),
            Text("Wallet",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600
              ),),

            SizedBox(height: 150,),
            Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  height: 70,
                  width: 180,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 4,),
                      Text("Reward Point",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),),
                      SizedBox(height: 15,),
                      Text("100",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38
                        ),),
                    ],
                  ),
                ),
                SizedBox(width: 14,),
                Container(
                  height: 70,
                  width: 180,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 4,),
                      Text("Happy Bonus",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),),
                      SizedBox(height: 15,),
                      Text("0",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38
                        ),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
