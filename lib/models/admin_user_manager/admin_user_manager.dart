import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quem_ama_da_doce/models/app_user/app_user.dart';

import '../app_user/app_user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<AppUser> users = [];
  StreamSubscription? _subscription;

  void updateUser(UserManager userManager) {
    //a caso o usuário não seja admin, cancela o Stream, se for nulo não chama
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      //para reduzir o risco de um usuário comum ver a lista de usuários
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    //busca a lista uma vez quando acessa o app
    /*firestore.collection('users').get().then((snapshot) {
      users = snapshot.docs.map((e) => AppUser.fromDocument(e)).toList();
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      notifyListeners();
    });*/
    //escuta as alterações na lista instantaneamente, mas fica ouvindo o constantemente
    //O StreamSubscription é utilizado pelo dispose() para matar essa chamada
    firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.docs.map((e) => AppUser.fromDocument(e)).toList();
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      notifyListeners();
    });
  }

  @override
  dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  List<String> get names => users.map((e) => e.name).toList();
}
