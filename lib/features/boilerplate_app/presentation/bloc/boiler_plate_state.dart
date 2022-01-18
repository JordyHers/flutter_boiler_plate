part of 'boiler_plate_bloc.dart';

@immutable
abstract class BoilerPlateState {}

class BoilerPlateInitial extends BoilerPlateState {
  final List<Album> albums;
  BoilerPlateInitial({required this.albums});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BoilerPlateCompletedAlbum && o.albums == albums;
  }

  @override
  int get hashCode => albums.hashCode;
}

class BoilerPlateFetching extends BoilerPlateState {}

class BoilerPlateProvider extends BoilerPlateState with ChangeNotifier {
  List<UserClass> _userClassList = [
    UserClass(name: 'User 1', email: 'From provider', age: 21),
  ];

  List<UserClass> get userList => _userClassList;

  Future<List<UserClass>?> addNewUsers(UserClass user) async {
    _userClassList.add(user);
    notifyListeners();
    return _userClassList;
  }
}

class BoilerPlateCompletedPhotos extends BoilerPlateState {
  final List<Photo> photos;
  BoilerPlateCompletedPhotos(this.photos);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BoilerPlateCompletedPhotos && o.photos == photos;
  }

  @override
  int get hashCode => photos.hashCode;
}

class BoilerPlateCompletedAlbum extends BoilerPlateState {
  final List<Album> albums;
  BoilerPlateCompletedAlbum(this.albums);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BoilerPlateCompletedAlbum && o.albums == albums;
  }

  @override
  int get hashCode => albums.hashCode;
}

class BoilerPlateError extends BoilerPlateState {
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
