part of 'boiler_plate_bloc.dart';

@immutable
abstract class BoilerPlateState {}

class BoilerPlateInitial extends BoilerPlateState {}

class BoilerPlateFetching extends BoilerPlateState{}

class BoilerPlateCompleted extends BoilerPlateState{
  final List<User> users;
    BoilerPlateCompleted(this.users);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BoilerPlateCompleted && o.users == users;
  }

  @override
  int get hashCode => users.hashCode;
}
class BoilerPlateError extends BoilerPlateState{
  final String message;
   BoilerPlateError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BoilerPlateError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}


