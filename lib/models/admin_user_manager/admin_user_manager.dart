
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:quem_ama_da_doce/models/app_user/app_user.dart';

import '../app_user/app_user_manager.dart';

class AdminUsersManager extends ChangeNotifier{

  List<AppUser> users = [];

  void updateUser(UserManager userManager){
    if(userManager.adminEnabled){
      _listenToUsers();
    }
  }

  void _listenToUsers(){
    final faker = Faker();

    for(int i = 0; i < 1000; i++){
      users.add(AppUser(
          name: faker.person.name(),
          email: faker.internet.email()
      ));
    }

    users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    notifyListeners();
  }

  List<String> get names => users.map((e) => e.name).toList();

}