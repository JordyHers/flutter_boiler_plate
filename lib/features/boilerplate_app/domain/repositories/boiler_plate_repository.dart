import 'package:boilerplate/features/boilerplate_app/data/datasource/boilerplate_local_json.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import  'dart:async';

import 'package:boilerplate/features/boilerplate_app/domain/entities/model_provider.dart';


abstract class  BoilerPlateRepository {
  Future<List<User>> getLocalList(String id)async {}
  Future<List<User>> getRemoteList (String id) async{}
  //Future<void> getNotifierProvider ()async {}
}

class BoilerPlateRep implements BoilerPlateRepository{
 BoilerJsonDataSource boilerJsonSource = BoilerJsonDataSource();




  @override
  Future<List<User>> getLocalList (String id) async =>  await boilerJsonSource.getUserList(id);

  @override
  Future<List<User>> getRemoteList (String id) async => await boilerJsonSource.getRemoteUserList(id);

  // @override
  // Future<void> getNotifierProvider () async => await user.addNewUsers(users);


}