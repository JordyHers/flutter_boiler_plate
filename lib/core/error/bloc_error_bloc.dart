import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_error_event.dart';
part 'bloc_error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(ErrorInitial());

  @override
  Stream<ErrorState> mapEventToState(
    ErrorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
