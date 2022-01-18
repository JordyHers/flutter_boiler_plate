import 'dart:convert';

import 'package:boilerplate/core/utils/strings.dart' as strings;
import 'package:boilerplate/features/boilerplate_app/data/models/album_model.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/photo_model.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

abstract class BoilerJsonSource {
  Future<List<User>?> getUserList(String id) async {}
  Future<List<User>?> getRemoteUserList(String id) async {}
}

class BoilerJsonDataSource implements BoilerJsonSource {
  @override
  Future<List<User>?> getUserList(String id) async {
    var data = await rootBundle.loadString('assets/data.json');
    var jsonData = json.decode(data);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(u["id"], u["name"], u["username"], u["email"]);
      print(user);
      users.add(user);
    }
    return users;
  }

  @override
  Future<List<User>?> getRemoteUserList(String id) async {
    var data =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var jsonData = json.decode(data.body);
    List<User> users = [];
    print('****** GETTING REMOTE LIST OF USERS *******');
    for (var u in jsonData) {
      User user = User(u["id"], u["name"], u["username"], u["email"]);
      print(user);

      users.add(user);
    }
    return users;
  }

  ///This function returns The list of Albums from The Api
  @override
  Future<List<Album>?> getRemoteAlbumList() async {
    var data = await http.get(Uri.parse(strings.Strings.apiAlbums));
    var jsonData = json.decode(data.body);
    List<Album> albums = [];
    print('****** GETTING REMOTE LIST OF USERS *******');
    for (var al in jsonData) {
      Album album = Album(id: al["id"], title: al["title"]);
      print(album);
      albums.add(album);
    }
    return albums;
  }

  @override
  Future<List<Photo>> getRemotePhotoList() async {
    var data = await http.get(Uri.parse(strings.Strings.apiPhotos));
    var jsonData = json.decode(data.body);
    List<Photo> photos = [];
    print('****** GETTING REMOTE LIST OF USERS *******');
    for (var ph in jsonData) {
      Photo photo = Photo(
          id: ph["id"],
          title: ph["title"],
          url: ph["url"],
          thumbnailUrl: ph["thumbnailUrl"]);
      print(photo);

      photos.add(photo);
    }
    return photos;
  }
}
