import 'package:fasion_freak_flutter/models/laundry_model.dart';
import 'package:fasion_freak_flutter/screens/laundry/book.dart';
import 'package:flutter/material.dart';

class Laundryy extends StatefulWidget {
  final LaundryModel londry;
  final Function update;

  Laundryy({required this.londry, required this.update});

  @override
  _LaundryyState createState() => _LaundryyState();
}

class _LaundryyState extends State<Laundryy> {
  bool counter = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('hii there');
        setState(() {
          counter = !counter;
          addToLundryList(widget.londry);
        });
      },
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: counter == false ? Colors.white10 : Colors.green.shade100,
              border: Border.all(
                  color: counter == false ? Colors.black45 : Colors.red)),
          height: 300,
          child: Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.londry.title,
                    style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Rs. ${widget.londry.price}/Kg',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
