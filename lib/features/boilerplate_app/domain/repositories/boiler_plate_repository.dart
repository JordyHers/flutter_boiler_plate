import 'package:boilerplate/features/boilerplate_app/data/datasource/boilerplate_local_json.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import  'dart:async';



abstract class  BoilerPlateRepository {
  Future<List<User>> getLocalList(String id)async {}
  Future<List<User>> getRemoteList (String id) async{}
}

class BoilerPlateRep implements BoilerPlateRepository{
 BoilerJsonDataSource boilerJsonSource = BoilerJsonDataSource();
 BoilerPlateProvider users =BoilerPlateProvider();



  @override
  Future<List<User>> getLocalList (String id) async =>  await boilerJsonSource.getUserList(id);

  @override
  Future<List<User>> getRemoteList (String id) async => await boilerJsonSource.getRemoteUserList(id);




}