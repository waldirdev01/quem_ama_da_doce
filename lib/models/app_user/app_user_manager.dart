import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quem_ama_da_doce/models/app_user/app_user.dart';
import '../../helpers/helpers.dart';


class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  AppUser? appUser;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get isLoggedIn => appUser != null;

  Future<void> signUp({
    required AppUser userApp,
    required Function failFunction,
    required Function sucessFunction,
  }) async {
    loading = true;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: userApp.email,
        password: userApp.password!,
      );
      if (credential.user == null) return;
      userApp.id = credential.user!.uid;
      appUser = userApp;
      await userApp.saveData();
      sucessFunction();
    } on FirebaseAuthException catch (e) {
      failFunction(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signIn({
    required AppUser userApp,
    required Function failFunction,
    required Function sucessFunction,
  }) async {
    loading = true;
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: userApp.email,
        password: userApp.password!,
      );
      if (credential.user != null) {
        await _loadCurrentUser(user: credential.user);
      }

      sucessFunction();
    } on FirebaseAuthException catch (e) {
      failFunction(getErrorString(e.code));
    }
    loading = false;
  }

  static AppUser _toAppUser({
    required User user,
  }) {
    return AppUser(
      id: user.uid,
      name: user.displayName!,
      email: user.email!,
    );
  }

  signOut() {
    _auth.signOut();
    appUser = null;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? user}) async {
    final User? currentUser =user ??  _auth.currentUser;
    if (currentUser != null) {
      if (user != null) {
        final docUser = await firestore.collection('users').doc(user.uid).get();
        appUser = AppUser.fromDocument(docUser);
        final docAdmin = await firestore.collection('admins').doc(user.uid).get();
        if(docAdmin.exists){
          appUser!.admin = true;
          print(appUser!.admin);
          print('aqui');
        }
        notifyListeners();
        print(appUser!.admin);
        print('aqui');
      }
    }
  }
  bool get adminEnabled => appUser != null && appUser!.admin;
}
