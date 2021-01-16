import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MaterialIntermediate extends StatefulWidget {
  @override
  _MaterialIntermediateState createState() => _MaterialIntermediateState();
}

class _MaterialIntermediateState extends State<MaterialIntermediate> {
  VideoPlayerController playerController;
  VoidCallback listener;
  int progress = 0;
  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloadingvideo");

    receivePort.listen((message) {
      setState(() {
        progress = message;
      });
    });
    FlutterDownloader.registerCallback(downloadcall);
    super.initState();
  }

  static downloadcall(id, status, progress) {
    SendPort sendPort;
    sendPort = IsolateNameServer.lookupPortByName("downloadingvideo");
    sendPort.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intermediate'),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Intermediate').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data.documents.map((document) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.green[200]),
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          padding: EdgeInsets.all(1),
                          child: Center(
                            child: Text(
                              document['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                          )),
                      YoutubePlayer(
                          controller: YoutubePlayerController(
                              initialVideoId: YoutubePlayer.convertUrlToId(
                                  document['videoUrl']),
                              flags: YoutubePlayerFlags(
                                  enableCaption: false,
                                  isLive: false,
                                  autoPlay: false))),
                      progress == 100
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    decoration:
                                        BoxDecoration(color: Colors.green[200]),

                                    // decoration: BoxDecoration(color: Colors.green),
                                    child: Center(
                                        child: RaisedButton(
                                      color: Colors.green[200],
                                      child: Text('The file has been dowloaded',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      onPressed: () async {
                                        final request =
                                            await Permission.storage.request();
                                        if (request.isGranted) {
                                          final storagePath =
                                              await getExternalStorageDirectory();
                                          await FlutterDownloader.enqueue(
                                              url: document['docUrl'],
                                              savedDir: storagePath.path,
                                              fileName: document['title']);
                                        } else {
                                          print('Not permssion');
                                        }
                                      },
                                    ))),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    decoration:
                                        BoxDecoration(color: Colors.green[200]),
                                    child: Center(
                                        child: RaisedButton(
                                      color: Colors.green,
                                      child: Text(
                                        'Download Material of the Lesson',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        final request =
                                            await Permission.storage.request();
                                        if (request.isGranted) {
                                          final storagePath =
                                              await getExternalStorageDirectory();
                                          await FlutterDownloader.enqueue(
                                              url: document['docUrl'],
                                              savedDir: storagePath.path,
                                              fileName: document['title']);
                                        } else {
                                          print('Not permssion');
                                        }
                                      },
                                    ))),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(' ')
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
