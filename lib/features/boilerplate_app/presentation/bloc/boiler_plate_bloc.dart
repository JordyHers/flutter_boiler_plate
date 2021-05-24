import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:boilerplate/features/boilerplate_app/domain/repositories/boiler_plate_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/features/boilerplate_app/domain/entities/model_provider.dart';
part 'boiler_plate_event.dart';
part 'boiler_plate_state.dart';

class BoilerPlateBloc extends Bloc<BoilerPlateEvent, BoilerPlateState> {
  final BoilerPlateRepository boilerPlateRepository;
  final BuildContext context;

  BoilerPlateBloc(this.boilerPlateRepository,this.context) : super(BoilerPlateInitial());



  @override
  Stream<BoilerPlateState> mapEventToState(
    BoilerPlateEvent event,
  ) async* {
    if (event is GetLocalUsers) {
      try {
        yield BoilerPlateFetching();
        final users = await boilerPlateRepository.getLocalList('1234');
        yield BoilerPlateCompleted(users);
      } on Exception {
        yield BoilerPlateError("Couldn't fetch user list. Is the device online?");
      }
    }
    else if (event is GetRemoteUsers){
      try {
        yield BoilerPlateFetching();
        final users = await boilerPlateRepository.getRemoteList('1234');
        yield BoilerPlateCompleted(users);
      } on Exception {
        yield BoilerPlateError("Couldn't fetch user list. Is the device online?");
      }
    } else if(event is GetProvider){
      final userList= Provider.of<UserClass>(context, listen: false);
      try {
        yield BoilerPlateFetching();
        var user = UserClass(name: 'Jordy Hershel', email: 'From UserClass',age: 25);
        userList.userList.add(user);
      }
      on Exception {
        yield BoilerPlateError("Couldn't fetch user list. Is the device online?");

      }
    }


    else {
      yield BoilerPlateError("Couldn't fetch user list. Is the device online?");
    }
  }
}
