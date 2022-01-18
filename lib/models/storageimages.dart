import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStorageService extends ChangeNotifier {
  static FirebaseAuth fauth = FirebaseAuth.instance;


  static Future<dynamic> loadFromStorage(BuildContext context, String image) async {
    final FirebaseUser currentUser = await fauth.currentUser();
    String uid = currentUser.uid.toString();
    return await FirebaseStorage.instance.ref().child('users/$uid').getDownloadURL();
  }
}