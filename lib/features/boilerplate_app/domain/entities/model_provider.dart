import 'package:flutter/cupertino.dart';

class UserClass with ChangeNotifier{
  final String name;
  final String email;
  final int age;
  List<UserClass> _userClassList =[];

  List<UserClass> get userList=> _userClassList;
  UserClass({this.name, this.email, this.age});


  factory UserClass.add(String name , String email , int age) => UserClass (name: name , email: email, age: age);


  Future <void> addNewUser (UserClass user)async {
    _userClassList.add(user);
    notifyListeners();
  }
}