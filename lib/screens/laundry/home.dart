import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'book.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


String _value = 'None';

class _HomeState extends State<Home> {
  String _chosenValue = '0';
  void tapper() {
    showDialog(
        context: context,
        builder: (builder) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: Text('Please Select a City'),
                content: DropdownButton(
                  hint: _value == null
                      ? Text('Dropdown')
                      : Text(
                          _value,
                          style: TextStyle(color: Colors.blue),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: ['None', 'Preet vihar', 'Laksham Pur'].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  value: _value,
                  onChanged: (val) {
                    _value = val.toString();
                    setState(
                      () {
                        _value;
                      },
                    );
                  },
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Book(_value)));
                      },
                      child: Text('Next'))
                ],
              ),
            ));

    //  DropdownButton<String>(
    //     value: _value.toString(),
    //     items: [
    //       DropdownMenuItem(
    //         child: Text("First Item"),
    //         value: 1.toString(),
    //       ),
    //       DropdownMenuItem(
    //         child: Text("Second Item"),
    //         value: 2.toString(),
    //       )
    //     ],
    //     onChanged: (String? value) {
    //       setState(() {
    //         _value = int.parse(value!);
    //       });
    //     },
    //     hint: Text("Select item"))
    //  hint: Text("Select City")),
    //   actions: [
    //     ElevatedButton(
    //         onPressed: () {
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (builder) => Book()));
    //         },
    //         child: Text('Next'))
    //   ],
    // ));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Widget _image = new Container(
      height: 260,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/img1.jpg'),
          AssetImage('assets/img2.jpg'),
          AssetImage('assets/img3.jpg'),
          AssetImage('assets/img4.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(microseconds: 800),
        dotSize: 6.0,
        indicatorBgPadding: 5,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Freak'),
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chat_outlined,
                color: Colors.white,
                size: 18,
              )),
          SizedBox(
            width: 1.0,
            height: 5,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone_sharp,
                color: Colors.white,
                size: 18,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            Container(
              child: ListView(shrinkWrap: true, children: // [_image],
                  [
                CarouselSlider(
                  items: [
                    Image.asset(
                      'assets/img1.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/img2.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/img3.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/img4.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                  options: CarouselOptions(
                    height: 250.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    viewportFraction: 0.8,
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Book Services',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ),
                // DropdownButton(
                //     value: _value,
                //     items: [
                //       DropdownMenuItem(
                //         child: Text("First Item"),
                //         value: 1,
                //       ),
                //       DropdownMenuItem(
                //         child: Text("Second Item"),
                //         value: 2,
                //       )
                //     ],
                //     onChanged: (int? value) {
                //       setState(() {
                //         _value = value ?? 1;
                //       });
                //     },
                //     hint: Text("Select item"))
              ],
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 10),
                  children: [
                    InkWell(
                      onTap: () {
                        // DropdownButton<String>(
                        //   items:
                        //       <String>['A', 'B', 'C', 'D'].map((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        //   onChanged: (_) {},
                        // );
                        tapper();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/wash_fold.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Wash & Fold',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tapper();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/laundry.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Laundry',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tapper();
                      },
                      child: Container(
                        // padding: const EdgeInsets.all(10),
                        // margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black45,
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/pre_laundry.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Premium Laundry',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tapper();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/org_wash.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Organic Wash',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tapper();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/woolen.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Woolen Wash',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tapper();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/curtains.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Curtain Wash',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tapper();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/iron.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Ironing',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tapper();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/iron-board.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Premium Ironing',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tapper();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black45)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/sweater.png',
                                height: 70,
                              ),
                            ),
                            Text(
                              'Woolen Ironing',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 28,
            // ),
            // Column(
            //   children: [
            //     Container(
            //       width: size.width,
            //       height: 80,
            //       //color: Colors.black,
            //       child: Stack(
            //         children: [
            //           CustomPaint(
            //             size: Size(size.width, 80),
            //             painter: BNBCustomPainter(),
            //           ),
            //           Center(
            //             heightFactor: 0.6,
            //             child: FloatingActionButton(
            //               onPressed: () {},
            //               backgroundColor: Colors.black26,
            //               child: Icon(Icons.calendar_today_rounded),
            //               elevation: 0.1,
            //             ),
            //           ),
            //           Container(
            //             width: size.width,
            //             height: 80,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.only(left: 5),
            //                   child: IconButton(
            //                       onPressed: () {},
            //                       icon: Icon(
            //                         Icons.home,
            //                         color: Colors.white,
            //                         size: 30,
            //                       )),
            //                 ),
            //                 IconButton(
            //                     onPressed: () {},
            //                     icon: Icon(
            //                       Icons.content_paste_outlined,
            //                       color: Colors.white,
            //                       size: 25,
            //                     )),
            //                 Container(
            //                   width: size.width * 0.15,
            //                 ),
            //                 IconButton(
            //                     onPressed: () {
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (builder) => Book()));
            //                     },
            //                     icon: Icon(
            //                       Icons.monetization_on_outlined,
            //                       color: Colors.white,
            //                       size: 30,
            //                     )),
            //                 Padding(
            //                   padding: const EdgeInsets.only(right: 5),
            //                   child: IconButton(
            //                     onPressed: () {},
            //                     icon: Icon(
            //                       Icons.account_circle_sharp,
            //                       color: Colors.white,
            //                       size: 30,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
