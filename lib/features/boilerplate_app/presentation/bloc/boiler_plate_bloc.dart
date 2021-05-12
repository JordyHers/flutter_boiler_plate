import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:boilerplate/features/boilerplate_app/domain/repositories/boiler_plate_repository.dart';
import 'package:meta/meta.dart';

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
        yield BoilerPlateCompleted(users);
      } on Exception {
        yield BoilerPlateError("Couldn't fetch weather. Is the device online?");
      }
    }
    else{
      try {
        yield BoilerPlateFetching();
        final users = await boilerPlateRepository.getRemoteList('1234');
        yield BoilerPlateCompleted(users);
      } on Exception {
        yield BoilerPlateError("Couldn't fetch weather. Is the device online?");
      }

    }
  }
}
