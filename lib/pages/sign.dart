import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siginsignup/pages/loading.dart';
import 'package:siginsignup/pages/studentProfile.dart';
import 'package:siginsignup/pages/studentReg.dart';

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  DateTime current = new DateTime.now();
  String email;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String password;
  String errorMessage = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formkey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      child: Center(
                    child: Image(
                        height: 110,
                        width: 140,
                        image: AssetImage('assets/student.png'),
                        fit: BoxFit.cover),
                  )),
                  Center(
                    child: Text.rich(TextSpan(
                        text: 'ARAB',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 60.0),
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
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: Text(
                      errorMessage.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[300]),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Center(
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          } else
                            return null;
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.email)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Center(
                      child: TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          } else if (value.length < 6) {
                            return "Password should be atleast 6 characters";
                          } else
                            return null;
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            hintText: '***************',
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.vpn_key)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: FlatButton(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            try {
                              setState(() {
                                loading = true;
                              });
                              AuthResult result = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password);
                              DocumentSnapshot passingData = await Firestore
                                  .instance
                                  .collection('students')
                                  .document(result.user.uid.toString())
                                  .get();
                              List data = passingData.data.values.toList();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentProfile(),
                                      settings:
                                          RouteSettings(arguments: data)));
                              if (result == null) {
                                loading = false;
                              }
                            } catch (error) {
                              switch (error.code) {
                                case "ERROR_INVALID_EMAIL":
                                  setState(() {
                                    errorMessage =
                                        "Your email address appears to be malformed.";
                                    loading = false;
                                  });
                                  break;
                                case "ERROR_WRONG_PASSWORD":
                                  setState(() {
                                    errorMessage = "Your password is wrong.";
                                    loading = false;
                                  });

                                  break;
                                case "ERROR_USER_NOT_FOUND":
                                  setState(() {
                                    errorMessage =
                                        "User with this email doesn't exist.";
                                    loading = false;
                                  });

                                  break;
                                case "ERROR_USER_DISABLED":
                                  setState(() {
                                    errorMessage =
                                        "User with this email has been disabled.";
                                    loading = false;
                                  });

                                  break;
                                case "ERROR_TOO_MANY_REQUESTS":
                                  setState(() {
                                    errorMessage =
                                        "Too many requests. Try again later.";
                                    loading = false;
                                  });

                                  break;
                                case "ERROR_OPERATION_NOT_ALLOWED":
                                  setState(() {
                                    errorMessage =
                                        "Signing in with Email and Password is not enabled.";
                                    loading = false;
                                  });

                                  break;
                                default:
                                  setState(() {
                                    errorMessage =
                                        "An undefined Error happened.";
                                    loading = false;
                                  });
                              }
                            }

                            if (errorMessage != null) {
                              return Future.error(errorMessage);
                            }
                          } else {
                            print('Not Validate');
                            loading = false;
                          }
                        },
                      )),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      SizedBox(width: 2.0),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentReg(),
                              ));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[300]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
