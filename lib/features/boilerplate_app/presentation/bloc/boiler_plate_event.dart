part of 'boiler_plate_bloc.dart';

@immutable
abstract class BoilerPlateEvent {

}

class GetLocalUsers extends BoilerPlateEvent{}

class GetRemoteUsers extends BoilerPlateEvent{}
