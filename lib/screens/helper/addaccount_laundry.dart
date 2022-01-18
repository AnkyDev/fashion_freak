import 'package:fasion_freak_flutter/db/Realtime_DB.dart';
import 'package:fasion_freak_flutter/models/laundry_model.dart';
import 'package:fasion_freak_flutter/screens/laundry/payment_laundry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddaccountLaundry extends StatefulWidget {
  final String dateFix;
  final String timeFix;
  final String selectedDate;
  final String selectedTime;
  final String city;
  final List<LaundryModel> selectedlaundry;
  AddaccountLaundry({
    required this.dateFix,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedlaundry,
    required this.timeFix,
    required this.city,
  });

  @override
  _AddaccountLaundryState createState() => _AddaccountLaundryState();
}

class _AddaccountLaundryState extends State<AddaccountLaundry> {
  TextEditingController Name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController pin = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController house = new TextEditingController();
  TextEditingController road = new TextEditingController();
  late String address;
  late String name;
  late String number;
  late String ProfileUrl;

  Future<void> getinfo() async {
    DatabaseReference dbref;
    FirebaseAuth fauth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await fauth.currentUser();
    dbref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('profiledetails');
    await dbref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        name = snapshot.value['name'].toString();
        number = snapshot.value['number'].toString();
        ProfileUrl = snapshot.value['ProfileUrl'].toString();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Add your Account'),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView(
                children: [
                  nameTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  phoneNumberField(),
                  SizedBox(
                    height: 20,
                  ),
                  pinCodeField(),
                  SizedBox(
                    height: 20,
                  ),
                  stateField(),
                  SizedBox(
                    height: 20,
                  ),
                  cityField(),
                  SizedBox(
                    height: 20,
                  ),
                  houseField(),
                  SizedBox(
                    height: 20,
                  ),
                  roadField(),
                  saveAddressButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: Name,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "Name",
        hintText: "Name (Required*)",
      ),
    );
  }

  Widget phoneNumberField() {
    return TextFormField(
      controller: phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "Phone Number",
        hintText: "Phone Number (Required*)",
      ),
    );
  }

  Widget pinCodeField() {
    return TextFormField(
      controller: pin,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "Pin Code",
        hintText: "Pin Code (Required*)",
      ),
    );
  }

  Widget stateField() {
    return TextFormField(
      controller: state,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "State",
        hintText: "State (Required*)",
      ),
    );
  }

  Widget cityField() {
    return TextFormField(
      controller: city,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "City",
        hintText: "City (Required*)",
      ),
    );
  }

  Widget houseField() {
    return TextFormField(
      controller: house,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "House No.",
        hintText: "House No., Building Name (Required*)",
      ),
    );
  }

  Widget roadField() {
    return TextFormField(
      controller: road,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "Road Name",
        hintText: "Road Name, Area, Colony (Required*)",
      ),
    );
  }

  Widget saveAddressButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              //save info
              address = house.text +
                  ", " +
                  road.text +
                  ", " +
                  city.text +
                  "(" +
                  pin.text +
                  ")" +
                  " , " +
                  state.text;
              Realtimedb.saveinfo(number, name, address, ProfileUrl);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Address Saved Successfully')));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              setState(() {
                print('recall');
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => PaymentLaundry(
                            dateFix: widget.dateFix,
                            timeFix: widget.timeFix,
                            selectedLaundry: widget.selectedlaundry,
                            selectedDate: widget.selectedDate,
                            selectedTime: widget.selectedTime,
                            city: widget.city,
                          )));
            },
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Text(
                "Save Address",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF000000);
    Path path = Path()
      ..relativeLineTo(0, 180)
      ..quadraticBezierTo(size.width / 2, 10.0, size.width, 180)
      ..relativeLineTo(0, -250)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
