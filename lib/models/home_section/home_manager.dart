import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quem_ama_da_doce/models/home_section/section.dart';

class HomeManager extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  HomeManager() {
    _loadSections();
  }
List<Section> sections = [];
  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      final sectionsFirebase = snapshot.docs
          .where((document) => document.exists)
          .map((document) => Section.fromDocument(document))
          .toList();
      sections = sectionsFirebase;
    notifyListeners();
    });
  }
}