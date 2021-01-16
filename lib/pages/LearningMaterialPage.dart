import 'package:flutter/material.dart';
import 'package:siginsignup/pages/MaterialAdvanced.dart';
import 'package:siginsignup/pages/MaterialIntermediate.dart';
import 'package:siginsignup/pages/studentProfile.dart';
import 'package:siginsignup/pages/viewMaterialBeginner.dart';

class LearingMaterialPage extends StatefulWidget {
  @override
  _LearingMaterialPageState createState() => _LearingMaterialPageState();
}

class _LearingMaterialPageState extends State<LearingMaterialPage> {
  @override
  Widget build(BuildContext context) {
    List datastudnets = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            'Lessons',
            style: TextStyle(
                color: Colors.blue[300],
                fontWeight: FontWeight.bold,
                fontSize: 23.0),
          )),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 300,
              height: 331,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Beginner'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        child: Image.asset(
                          'assets/beginner.jpg',
                        ),
                      )
                    ]),
                  ),
                  Container(
                    width: 150,
                    child: FlatButton(
                      child: Text(
                        'View',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaterialBegineer(),
                            ));
                      },
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.pinkAccent.withOpacity(0.2)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 300,
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Intermediate'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        child: Image.asset(
                          'assets/inter.jpg',
                          height: 230,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      )
                    ]),
                  ),
                  Container(
                    width: 150,
                    child: FlatButton(
                      child: Text(
                        'View',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaterialIntermediate(),
                            ));
                      },
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(), color: Colors.blue.withOpacity(0.5)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 300,
              height: 325,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Advance'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        child: Image.asset(
                          'assets/advanced.jpg',
                        ),
                      )
                    ]),
                  ),
                  Container(
                    width: 150,
                    child: FlatButton(
                      child: Text(
                        'View',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaterialAdvance(),
                            ));
                      },
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(), color: Colors.grey.withOpacity(0.2)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LearingMaterialPage(),
                        settings: RouteSettings(arguments: datastudnets)));
              },
              icon: Icon(
                Icons.school,
                size: 23,
                color: Colors.blue[300],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentProfile(),
                        settings: RouteSettings(arguments: datastudnets)));
              },
              icon: Icon(
                Icons.settings,
                size: 23,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
