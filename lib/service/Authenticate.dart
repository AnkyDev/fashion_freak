import 'package:fasion_freak_flutter/screens/option.dart';
import 'package:fasion_freak_flutter/screens/phoneauth_screen.dart';
import 'package:fasion_freak_flutter/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authenticate {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("you already have user");
            return option();
          } else
            print("Uh oh you need to login");
          return welcome();
        });
  }
}
