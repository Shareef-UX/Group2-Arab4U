import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:siginsignup/pages/LearningMaterialPage.dart';
import 'package:siginsignup/pages/editProfile.dart';

import 'package:siginsignup/pages/welcome.dart';

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String studentImage;
  String id;
  var downloadUrl;
  List datastudnets;
  @override
  Widget build(BuildContext context) {
    datastudnets = ModalRoute.of(context).settings.arguments;
    id = datastudnets[2];

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                FirebaseAuth.instance
                    .signOut()
                    .whenComplete(() => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomePage(),
                        )));
              },
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(2))),
            )
          ],
          backgroundColor: Colors.blue[300],
          title: Text(
            'Your Profile',
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView(children: [
          Container(
            child: Column(
              children: [
                (studentImage != null)
                    ? Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(studentImage))))
                    : Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(datastudnets[5]))),
                      ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        uploadImage();
                      },
                      child: Text(
                        'Change photo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Full Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  datastudnets[0].toString() + " " + datastudnets[2].toString(),
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

///////////////////////////////////
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  datastudnets[6],
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              //////////////////////////////////////////////////
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Gender',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),

              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  datastudnets[4],
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditStudentPro(),
                          settings: RouteSettings(
                              arguments: datastudnets[1].toString())));
                },
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      height: 45,
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(2))),
                ),
              ),
              /////////////////////CHAT AND CALL/////

              SizedBox(
                height: 2.0,
              ),

              ///////////////////////////////////////////////////
            ],
          )
        ]),
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
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  size: 23,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ));
  }

  uploadImage() async {
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await ImagePicker().getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await FirebaseStorage.instance
            .ref()
            .child('students/profile/${datastudnets[6].toString()}')
            .putFile(file)
            .onComplete;

        downloadUrl = await snapshot.ref.getDownloadURL();
        print('Done');
        setState(() {
          datastudnets[5] = downloadUrl;
          Firestore()
              .collection('students')
              .document(datastudnets[6])
              .updateData({"photo": downloadUrl});
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
