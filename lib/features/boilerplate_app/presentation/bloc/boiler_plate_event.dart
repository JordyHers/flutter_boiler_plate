part of 'boiler_plate_bloc.dart';

@immutable
abstract class BoilerPlateEvent {

}

class GetLocalUsers extends BoilerPlateEvent{}

class GetRemoteUsers extends BoilerPlateEvent{}

class GetRemoteAlbums extends BoilerPlateEvent{}

class GetRemotePhotos extends BoilerPlateEvent{}

class GetError extends BoilerPlateEvent{}

class GetProvider extends BoilerPlateEvent{}

class GetInitialInput extends BoilerPlateEvent{}
