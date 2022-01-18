import 'package:fasion_freak_flutter/screens/jewellery/Profile_Section.dart';
import 'package:fasion_freak_flutter/screens/jewellery/wallet_screen.dart';
import 'package:fasion_freak_flutter/screens/laundry/book.dart';
import 'package:fasion_freak_flutter/screens/laundry/date_picker.dart';
import 'package:fasion_freak_flutter/screens/laundry/home.dart';
import 'package:fasion_freak_flutter/screens/laundry/order_screen_lon.dart';
import 'package:fasion_freak_flutter/screens/laundry/profile_laundry.dart';
import 'package:flutter/material.dart';

class BottomNavHomeScreen extends StatefulWidget {
  const BottomNavHomeScreen({Key? key}) : super(key: key);

  @override
  _BottomNavHomeScreenState createState() => _BottomNavHomeScreenState();
}

class _BottomNavHomeScreenState extends State<BottomNavHomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    // HomeDate(),
    Book('None'),
    WalletScreen(),
    ProfileLaundry(),//OrderScreenLondry(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home', //Text('Home').toString(),
              backgroundColor: Colors.black),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Pricing',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
          backgroundColor: Colors.black,
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Profile',
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
}
