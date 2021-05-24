import 'package:flutter/cupertino.dart';

class UserClass with ChangeNotifier{
  UserClass({this.name, this.email, this.age});
  final String name;
  final String email;
  final int age;
  //TODO: Modify this part to fecth it from repository
  List<UserClass> _userClassList = [];

  List<UserClass> get userList => _userClassList;



   factory UserClass.add(String name , String email , int age) => UserClass (name: name , email: email, age: age);



  Future <void> addNewUsers (List<UserClass> users)async {
    _userClassList = users;
    notifyListeners();
    return _userClassList;
  }
}