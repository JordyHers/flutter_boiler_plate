import 'package:flutter/material.dart';

abstract class UserModel{

}

class User extends ChangeNotifier implements UserModel{
   int id;
   String name;
   String username;
   String email;


   User(this.id,this.name,this.username,this.email);


}