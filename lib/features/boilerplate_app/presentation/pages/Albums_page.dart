import 'package:boilerplate/features/boilerplate_app/data/models/album_model.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/photo_model.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:boilerplate/features/boilerplate_app/domain/entities/model_provider.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/widgets/cardsTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AlbumsPage extends StatelessWidget {
  AlbumsPage({Key key}) : super(key: key);

  ///Methods To send to Bloc => Local User
  void sendLocalToBloC(BuildContext context) {
    var boilerPlateBloc = context.read<BoilerPlateBloc>();
    boilerPlateBloc.add(GetLocalUsers());
    Navigator.pop(context);
  }

  ///Methods To send to Bloc => Remote User
  void sendRemoteToBloCAlbum(BuildContext context) {
    var boilerPlateBloc = context.read<BoilerPlateBloc>();
    boilerPlateBloc.add(GetRemoteAlbums());
    Navigator.pop(context);
  }

  ///Methods To send to Bloc => Remote User
  void sendRemoteToBloCPhotos(BuildContext context) {
    var boilerPlateBloc = context.read<BoilerPlateBloc>();
    boilerPlateBloc.add(GetRemotePhotos());
    Navigator.pop(context);
  }



  ///Methods To send Provider to Bloc
  void sendProviderToBloC(BuildContext context) {
    final user = Provider.of<BoilerPlateProvider>(context,listen: false);
    var order = user.userList.length +1;
    var newUser = UserClass(name :'User $order', email:'User$order@Provider.com', age:21);
    user.addNewUsers(newUser);
    var boilerPlateBloc = context.read<BoilerPlateBloc>();
    boilerPlateBloc.add(GetProvider());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('Scaffold_key'),
        drawer: buildDrawer(context),
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Albums Page'),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: BlocConsumer<BoilerPlateBloc, BoilerPlateState>(
              listener: (context, state) {
                if (state is BoilerPlateError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is BoilerPlateInitial) {
                  return buildInitialInput(context);
                } else if (state is BoilerPlateFetching) {
                  return buildLoading();
                } else if (state is BoilerPlateCompletedAlbum) {
                  return buildListViewData(state.albums);
                }else if (state is BoilerPlateCompletedPhotos) {
                  return buildListViewPhotos(state.photos);
                } else {
                  return buildInitialInput(context);
                }
              },
            ),
          ),
        ));
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
        key: Key('Drawer_key'),
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                key: Key('Container_Key'),
                color: Colors.indigo,
                height: 130,
                width: double.maxFinite,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text('Get Local Users'),
              leading: Icon(Icons.local_fire_department_sharp),
              onTap: () async => sendLocalToBloC(context),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.computer),
              title: Text('Get Albums'),
              onTap: () async =>  sendRemoteToBloCAlbum(context),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.computer),
              title: Text('Get Photos'),
              onTap: () async =>  sendRemoteToBloCPhotos(context),
            ),

            ListTile(
              leading: Icon(Icons.compass_calibration_sharp),
              title: Text('Notifier Provider'),

              onTap: () async =>  sendProviderToBloC(context),
            ),
          ],
        ));
  }

  Widget buildInitialInput(BuildContext context) {
    return Center(child: Text('Home Page',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        )));

  }

  Widget buildProviderView(BuildContext context){
    return Consumer<BoilerPlateProvider>(
      builder: (context,user,child) => Center(
          child: ListView.builder(
              itemCount: user.userList.length,
              itemBuilder: (context, index) {
                //TODO: DISMISS THE DISMISSIBLE
                return Dismissible(
                  background: Container(color: Colors.red,),
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                //  onDismissed: (_)=> _delete(user,context),
                  child: ListTile(
                    title: Text(user.userList[index].name),
                    subtitle: Text(user.userList[index].email),
                    leading: Icon(Icons.person),
                  ),
                );
              })),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),),
    );
  }

  Widget buildListViewData(List<Album> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              users[index].title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            leading: Text(
              users[index].id.toString(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
            ),
          );
        });
  }

  Widget buildListViewPhotos(List<Photo> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              users[index].title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            trailing:  Tiles(photo: users[index]),
            leading: Text(
              users[index].id.toString(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
            ),
          );
        });
  }
}
