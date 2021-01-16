import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialsData {
  Future materiaBeginnerlData(
      String title, String videoUrl, String docUrl) async {
    try {
      DocumentReference doc =
          await Firestore.instance.collection('Beginner').document(title);
      Map<String, String> data = {
        'title': title,
        'videoUrl': videoUrl,
        'docUrl': docUrl
      };
      doc.setData(data);
    } catch (e) {
      print(e);
    }
  }

  Future materialIntermediateData(
      String title, String videoUrl, String docUrl) async {
    try {
      DocumentReference doc =
          await Firestore.instance.collection('Intermediate').document(title);
      Map<String, String> data = {
        'title': title,
        'videoUrl': videoUrl,
        'docUrl': docUrl
      };
      doc.setData(data);
    } catch (e) {
      print(e);
    }
  }

  Future materiaAdvancedlData(
      String title, String videoUrl, String docUrl) async {
    try {
      DocumentReference doc =
          await Firestore.instance.collection('Advanced').document(title);
      Map<String, String> data = {
        'title': title,
        'videoUrl': videoUrl,
        'docUrl': docUrl
      };
      doc.setData(data);
    } catch (e) {
      print(e);
    }
  }
}
