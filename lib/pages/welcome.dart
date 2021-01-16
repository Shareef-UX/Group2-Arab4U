import 'package:flutter/material.dart';
import 'package:siginsignup/pages/sign.dart';
import 'package:siginsignup/pages/studentReg.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 150,
          ),
          Center(
            child: Text.rich(TextSpan(
                text: 'ARAB',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60.0),
                children: <InlineSpan>[
                  TextSpan(
                    text: '4',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.0,
                        color: Colors.blue[300]),
                  ),
                  TextSpan(
                    text: 'U',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.0,
                        color: Colors.black),
                  )
                ])),
          ),
          Center(
            child: Container(
              child: Text(
                'Learn with Native Speakers',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.blue[300]),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 150,
                  minHeight: 150,
                  maxWidth: 150,
                  maxHeight: 150,
                ),
                child: Image.asset(
                  'assets/student.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: FlatButton(
                child: Text(
                  'Get started'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentReg(),
                      ));
                },
              )),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have an account?'),
              SizedBox(width: 2.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Sign(),
                      ));
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue[300]),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
