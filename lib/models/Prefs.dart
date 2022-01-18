import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserModel.dart';

class Prefs {
  static void setUser(FirebaseUser user) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userId", user.uid);
    preferences.setString("mobile", user.phoneNumber);
  }

  static Future<AppUser> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString("userId");
    String mobile = preferences.getString("mobile");

    return AppUser( uid: uid, mobile: mobile);
  }


  static void logOut() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userId", "");
    preferences.setString("mobile", "");
  }
}