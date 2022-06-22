import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:gomez_todo/src/scr/auth/acc_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthCtrl with ChangeNotifier {
  final Box accsStash = Hive.box('accounts');
  Account? currUsr;
  List<Account> users = [];

  AuthCtrl() {
    List accsList = accsStash.get('accounts', defaultValue: []);
    print(accsStash);
    for (var userIter in accsList) {
      print(userIter);
      users.add(Account.fromJson(Map<String, dynamic>.from(userIter)));
    }
  }

  bool authenticate(String user, String pass) {
    print("Attempting to authenticate $user with $pass");
    for (Account userIter in users) {
      if (userIter.user == user && userIter.passKey == pass) {
        print("Authentication successful");
        currUsr = userIter;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  register(String usr, String pwd) {
    Account newUser = Account(user: usr, passKey: pwd);
    users.add(newUser);
    saveData();
    notifyListeners();
    print("New user added: " + usr);
  }

  saveData() {
    List<Map<String, dynamic>> accsList = [];
    for (Account accIter in users) {
      accsList.add(accIter.toJson());
    }
    print(accsList);
    accsStash.put('accounts', accsList);
  }
}
