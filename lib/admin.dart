import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:siginsignup/pages/LearningMaterialPage.dart';
import 'package:siginsignup/pages/admin/chooseMaterial.dart';
import 'package:siginsignup/pages/studentProfile.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text('Control Students'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('students').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return new ListView(
                  children: snapshot.data.documents
                      .map((DocumentSnapshot documentSnapshot) {
                return Dismissible(
                  key: ObjectKey(documentSnapshot.data),
                  onDismissed: (direction) {
                    documentSnapshot.reference.delete();
                    print(documentSnapshot.data);
                  },
                  direction: DismissDirection.startToEnd,
                  child: Card(
                    child: ListTile(
                      trailing: RaisedButton(
                        color: Colors.red,
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          documentSnapshot.reference.delete();
                          print(documentSnapshot.data);
                        },
                      ),
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 44,
                          maxHeight: 44,
                        ),
                        child: Image.network(
                          documentSnapshot.data['photo'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        documentSnapshot.data['fname'] +
                            ' ' +
                            documentSnapshot.data['lname'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }).toList());
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentControl(),
                    ));
              },
              child: Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 100,
                    minHeight: 100,
                    maxWidth: 100,
                    maxHeight: 100,
                  ),
                  child: Image.asset(
                    'assets/student.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.school,
                size: 40,
                color: Colors.blue[300],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseMaterial(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}

class StudentControl extends StatefulWidget {
  @override
  _StudentControlState createState() => _StudentControlState();
}

class _StudentControlState extends State<StudentControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text('Students Control'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('students').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return new ListView(
                  children: snapshot.data.documents
                      .map((DocumentSnapshot documentSnapshot) {
                return Dismissible(
                  key: ObjectKey(documentSnapshot.data),
                  onDismissed: (direction) {
                    documentSnapshot.reference.delete();
                    print(documentSnapshot.data);
                  },
                  direction: DismissDirection.startToEnd,
                  child: Card(
                    child: ListTile(
                      trailing: RaisedButton(
                        color: Colors.red,
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          documentSnapshot.reference.delete();
                          print(documentSnapshot.data);
                        },
                      ),
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 44,
                          maxHeight: 44,
                        ),
                        // child: Image.network(
                        //   documentSnapshot.data['photo'],
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      title: Text(
                        documentSnapshot.data['fname'] +
                            ' ' +
                            documentSnapshot.data['lname'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }).toList());
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 100,
                    minHeight: 100,
                    maxWidth: 100,
                    maxHeight: 100,
                  ),
                  child: Image.asset(
                    'assets/student.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 100,
                      maxWidth: 100,
                      maxHeight: 100,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseMaterial(),
                            ));
                      },
                      icon: Icon(
                        Icons.school,
                        size: 40,
                        color: Colors.blue[300],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
