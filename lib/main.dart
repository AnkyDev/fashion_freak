// @dart=2.9
import 'package:fasion_freak_flutter/db/db.dart';
import 'package:fasion_freak_flutter/screens/welcome_screen.dart';
import 'package:fasion_freak_flutter/service/Authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()  {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value:db.initialize())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authenticate().handleAuth(),);
  }
}

