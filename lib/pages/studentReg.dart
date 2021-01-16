import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:siginsignup/Model/students.dart';
import 'package:siginsignup/pages/sign.dart';

class StudentReg extends StatefulWidget {
  @override
  _StudentRegState createState() => _StudentRegState();
}

class _StudentRegState extends State<StudentReg> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String fname;
  String lname;
  String email;
  String password;
  String gender = 'Male';
  String errorMessage = '';
  String male = 'Male';
  String female = 'Female';
  int group = 1;
  var urlphoto;
  String textloadingphoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            SizedBox(
              height: 85.0,
            ),
            Container(
              child: Center(
                child: Text(
                  'Student Registration',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27.0,
                      color: Colors.blue[300]),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
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
                    fname = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 27.0,
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
                    lname = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 27.0,
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
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 27.0,
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
                  obscuringCharacter: '*',
                  validator: (String value) {
                    if (value.length < 6) {
                      return "* Password should be at least 6 characters";
                    } else if (value.isEmpty) {
                      return "* Required";
                    } else
                      return null;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.vpn_key)),
                ),
              ),
            ),
            SizedBox(
              height: 27.0,
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: group,
                          onChanged: (value) {
                            setState(() {
                              group = value;
                              gender = 'Male';
                            });
                          },
                        ),
                        Text(
                          'Male',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Radio(
                          value: 2,
                          groupValue: group,
                          onChanged: (value) {
                            setState(() {
                              group = value;
                              gender = 'Female';
                            });
                          },
                        ),
                        Text(
                          'Female',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 27.0,
            ),
            Container(
                height: 50,
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: textloadingphoto != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Uploaded sucessfully.',
                            style:
                                TextStyle(color: Colors.green, fontSize: 15.5),
                          ),
                          RaisedButton(
                            child: Text(
                              'Change',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              await Permission.photos.request();
                              var perm = await Permission.photos.status;
                              if (perm.isGranted) {
                                PickedFile pickedImage = await ImagePicker()
                                    .getImage(source: ImageSource.gallery);
                                var result = File(pickedImage.path);
                                if (result != null) {
                                  var snapshot = await FirebaseStorage.instance
                                      .ref()
                                      .child('students/profile/$email')
                                      .putFile(result)
                                      .onComplete;
                                  urlphoto =
                                      await snapshot.ref.getDownloadURL();
                                  setState(() {
                                    textloadingphoto = urlphoto.toString();
                                  });
                                } else {
                                  print('no image taken');
                                }
                              } else {
                                print('denied');
                              }
                            },
                            color: Colors.green[200],
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upload your photo profile',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 15.5),
                          ),
                          RaisedButton(
                            child: Text(
                              'Upload',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              await Permission.photos.request();
                              var perm = await Permission.photos.status;
                              if (perm.isGranted) {
                                PickedFile pickedImage = await ImagePicker()
                                    .getImage(source: ImageSource.gallery);

                                var result = File(pickedImage.path);
                                if (result != null) {
                                  var snapshot = await FirebaseStorage.instance
                                      .ref()
                                      .child('students/profile/$email')
                                      .putFile(result)
                                      .onComplete;
                                  urlphoto =
                                      await snapshot.ref.getDownloadURL();
                                  setState(() {
                                    textloadingphoto = urlphoto.toString();
                                  });
                                } else {
                                  print('no image taken');
                                }
                              } else {
                                print('denied');
                              }
                            },
                            color: Colors.green,
                          )
                        ],
                      )),
            SizedBox(
              height: 15.0,
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
                      'Register'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        try {
                          AuthResult result = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          StudentsMod().studnetsData(
                              result.user.uid.toString(),
                              fname,
                              lname,
                              email,
                              password,
                              gender,
                              textloadingphoto);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Sign(),
                              ));
                        } catch (error) {
                          switch (error.code) {
                            case "ERROR_OPERATION_NOT_ALLOWED":
                              setState(() {
                                errorMessage =
                                    "Anonymous accounts are not enabled";
                              });

                              break;
                            case "ERROR_WEAK_PASSWORD":
                              setState(() {
                                errorMessage = "Your password is too weak";
                              });

                              break;
                            case "ERROR_INVALID_EMAIL":
                              setState(() {
                                errorMessage = "Your email is invalid";
                              });

                              break;
                            case "ERROR_EMAIL_ALREADY_IN_USE":
                              setState(() {
                                errorMessage =
                                    "Email is already in use on different account";
                              });

                              break;
                            case "ERROR_INVALID_CREDENTIAL":
                              setState(() {
                                errorMessage = "Your email is invalid";
                              });

                              break;

                            default:
                              setState(() {
                                errorMessage = "An undefined Error happened.";
                              });
                          }
                        }
                        if (errorMessage != null) {
                          return Future.error(errorMessage);
                        }
                      } else {
                        print('Not validate');
                      }
                    })),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You have an account?'),
                SizedBox(width: 2.0),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
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
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
