import 'package:boilerplate/features/boilerplate_app/data/datasource/boilerplate_local_json.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import  'dart:async';

import 'package:boilerplate/features/boilerplate_app/domain/entities/model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

abstract class  BoilerPlateRepository {
  Future<List<User>> getLocalList(String id)async {}
  Future<List<User>> getRemoteList (String id) async{}
  Future<void> getNotifierProvider ()async {}
}

class BoilerPlateRep implements BoilerPlateRepository{
 final UserClass user;
 BoilerJsonDataSource boilerJsonSource = BoilerJsonDataSource();
 UserClass _class = UserClass();
 var users = [
   UserClass(name: 'User 1', email:'Provider',age:25),
   UserClass(name: 'User 2', email:'Provider',age:25),
   UserClass(name: 'User 3', email:'Provider',age:25),
   UserClass(name: 'User 4', email:'Provider',age:25),
   UserClass(name: 'User 5', email:'Provider',age:25),
   UserClass(name: 'User 6', email:'Provider',age:25),
 ];

  BoilerPlateRep(this.user);

  @override
  Future<List<User>> getLocalList (String id) async =>  await boilerJsonSource.getUserList(id);

  @override
  Future<List<User>> getRemoteList (String id) async => await boilerJsonSource.getRemoteUserList(id);

  @override
  Future<void> getNotifierProvider () async => await user.addNewUsers(users);


}