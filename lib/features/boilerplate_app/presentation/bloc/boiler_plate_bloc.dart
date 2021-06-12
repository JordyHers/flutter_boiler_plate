import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/album_model.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/photo_model.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:boilerplate/features/boilerplate_app/domain/repositories/boiler_plate_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:boilerplate/features/boilerplate_app/domain/entities/model_provider.dart';
part 'boiler_plate_event.dart';
part 'boiler_plate_state.dart';

class BoilerPlateBloc extends Bloc<BoilerPlateEvent, BoilerPlateState> {
  final BoilerPlateRepository boilerPlateRepository;


  BoilerPlateBloc(this.boilerPlateRepository) : super(BoilerPlateInitial());

  @override
  Stream<BoilerPlateState> mapEventToState(
    BoilerPlateEvent event,
  ) async* {
    if (event is GetLocalUsers) {
      try {
        yield BoilerPlateFetching();
        final users = await boilerPlateRepository.getLocalList('1234');
      //  yield BoilerPlateCompleted(users);
      } on Exception {
        yield BoilerPlateError("Couldn't fetch user list. Is the device online?");
      }
    }
    else if (event is GetRemoteAlbums){
      try {
        yield BoilerPlateFetching();
        final albums = await boilerPlateRepository.getRemoteAlbums();
        yield BoilerPlateCompletedAlbum(albums);
      } on Exception {
        yield BoilerPlateError("Couldn't fetch user list. Is the device online?");
      }
    }  else if (event is GetRemotePhotos){
      try {
        yield BoilerPlateFetching();
        final photos = await boilerPlateRepository.getRemotePhotos();
        yield BoilerPlateCompletedPhotos(photos);
      } on Exception {
        yield BoilerPlateError("Couldn't fetch user list. Is the device online?");
      }
    }
    else if(event is GetInitialInput){
      try {
        yield BoilerPlateFetching();
        final albums = await boilerPlateRepository.getRemoteAlbums();
        yield BoilerPlateCompletedAlbum(albums);
      } on Exception {
        yield BoilerPlateError("Couldn't fetch user list. Is the device online?");
      }
    }

    else {
      yield BoilerPlateError("Couldn't fetch user list. Is the device online?");
    }
  }
}
