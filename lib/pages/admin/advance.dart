import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:siginsignup/Model/Material_data.dart';

import 'chooseMaterial.dart';

class Advanced extends StatefulWidget {
  @override
  _AdvancedState createState() => _AdvancedState();
}

class _AdvancedState extends State<Advanced> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _videoUrl;
  String _docUrl;
  String loadingmaterial;
  String doc;
  String _title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text('Advance'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uploading Materials',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
          Form(
            key: _globalKey,
            child: Column(
              children: [
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
                        }
                      },
                      onChanged: (value) {
                        _title = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                        }
                      },
                      onChanged: (value) {
                        _videoUrl = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Url YouTube Video',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 50,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: loadingmaterial != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Uploaded sucessfully.',
                          style: TextStyle(color: Colors.green, fontSize: 15.5),
                        ),
                        RaisedButton(
                          child: Text(
                            'Change',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            File file = await FilePicker.getFile(
                                allowedExtensions: ['pdf', 'doc'],
                                type: FileType.custom);
                            setState(() {});

                            var result = File(file.path);
                            if (result != null) {
                              var snapshot = await FirebaseStorage.instance
                                  .ref()
                                  .child('material/beginner/$_docUrl')
                                  .putFile(file)
                                  .onComplete;
                              doc = await snapshot.ref.getDownloadURL();
                              setState(() {
                                loadingmaterial = doc;
                              });
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
                          'Upload Materials',
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 15.5),
                        ),
                        RaisedButton(
                          child: Text(
                            'Upload',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            File file = await FilePicker.getFile(
                                allowedExtensions: ['pdf', 'doc'],
                                type: FileType.custom);
                            setState(() {});

                            var result = File(file.path);
                            if (result != null) {
                              var snapshot = await FirebaseStorage.instance
                                  .ref()
                                  .child('material/advance/$_docUrl')
                                  .putFile(file)
                                  .onComplete;
                              doc = await snapshot.ref.getDownloadURL();
                              setState(() {
                                loadingmaterial = doc;
                              });
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
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: FlatButton(
                  child: Text(
                    'Submit'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  onPressed: () async {
                    if (_globalKey.currentState.validate()) {
                      MaterialsData().materiaAdvancedlData(
                          _title, _videoUrl, loadingmaterial);
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseMaterial()));
                    }
                  })),
        ],
      ),
    );
  }
}
