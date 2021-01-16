import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets/document.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MaterialBegineer extends StatefulWidget {
  @override
  _MaterialBegineerState createState() => _MaterialBegineerState();
}

class _MaterialBegineerState extends State<MaterialBegineer> {
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

  YoutubePlayerController _playerController = YoutubePlayerController(
      initialVideoId: 'fRRCRVoMjWI',
      flags: YoutubePlayerFlags(autoPlay: true, mute: false));

  void runYoutubeplayer() {
    _playerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(
            'https://www.youtube.com/watch?v=ZnevdXDH25Q'),
        flags: YoutubePlayerFlags(
            enableCaption: false, isLive: false, autoPlay: false));
  }

  // @override
  // void initState() {
  //   runYoutubeplayer();
  //   super.initState();
  // }

  // @override
  // void deactivate() {
  //   _playerController.pause();
  //   super.deactivate();
  // }

  // @override
  // void dispose() {
  //   _playerController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // return YoutubePlayerBuilder(
    //   player: YoutubePlayer(
    //     controller: _playerController,
    //   ),
    //   builder: (context, player) {
    //     return Scaffold(
    //       appBar: AppBar(
    //         title: Text('Video'),
    //       ),
    //       body: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [player, Text('Hello')],
    //         ),
    //       ),
    //     );
    //   },
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Beginner'),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Beginner').snapshots(),
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

                                    // decoration: BoxDecoration(color: Colors.green),
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
      // body: Container(
      //   padding: EdgeInsets.only(
      //     top: 10,
      //     left: 0,
      //   ),
      //   height: 700,
      //   decoration: BoxDecoration(
      //       color: Colors.white, borderRadius: BorderRadius.circular(20)),
      //   child: cards(),
      // ),
    );
  }
}
