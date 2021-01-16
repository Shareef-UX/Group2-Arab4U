import 'package:flutter/material.dart';
import 'package:siginsignup/pages/admin/Beginner.dart';

import 'advance.dart';
import 'intermediate.dart';

class ChooseMaterial extends StatefulWidget {
  @override
  _ChooseMaterialState createState() => _ChooseMaterialState();
}

class _ChooseMaterialState extends State<ChooseMaterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materials'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
      ),
      body: Center(
        child: (Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 97,
              decoration: BoxDecoration(color: Colors.blue[300]),
              child: RaisedButton(
                child: Text('Beginners', style: TextStyle(color: Colors.white)),
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Beginners(),
                      ));
                },
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 60,
              width: 120,
              child: RaisedButton(
                child:
                    Text('Intermediate', style: TextStyle(color: Colors.white)),
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Intermediate(),
                      ));
                },
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 60,
              width: 97,
              child: RaisedButton(
                child: Text('Advanced', style: TextStyle(color: Colors.white)),
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Advanced(),
                      ));
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
