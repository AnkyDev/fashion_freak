// @dart=2.9
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Tutorial',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: HomeDate(),
//     );
//   }
// }

class HomeDate extends StatefulWidget {
  @override
  HomeDateState createState() => new HomeDateState();
}

class HomeDateState extends State<HomeDate> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('checking date'),
          ),
          body: ElevatedButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("Alert Dialog title"),
                    content: new Text("Alert Dialog body"),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ); 
            },
          )),
    );
  }
}



