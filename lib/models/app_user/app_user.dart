import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? id, password;
  String name, email;
  bool admin = false;

  DocumentReference get firestoreRef  => FirebaseFirestore.instance.doc('users/$id');
  CollectionReference get cartReference => firestoreRef.collection('cart');

  AppUser({
    required this.name,
    required this.email,
    this.password,
    this.id,
  });

  AppUser.fromDocument(DocumentSnapshot<Map<String, dynamic>> document)
      : name = document['name'] as String,
        email = document['email'] as String{
    id = document.id;
  }
  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email':email,
    };
  }
}
