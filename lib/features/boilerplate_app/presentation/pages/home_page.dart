import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);



  ///Methods To send to Bloc => Local User
  void sendLocalToBloC(BuildContext context) {
    var boilerPlateBloc = context.read<BoilerPlateBloc>();
    boilerPlateBloc.add(GetLocalUsers());
    Navigator.pop(context);
  }

  ///Methods To send to Bloc => Remote User
  void sendRemoteToBloC(BuildContext context) {
    var boilerPlateBloc = context.read<BoilerPlateBloc>();
    boilerPlateBloc.add(GetRemoteUsers());
    Navigator.pop(context);
  }

  ///Methods To send ERROR to Bloc
  void sendErrorToBloC(BuildContext context) {
    var boilerPlateBloc = context.read<BoilerPlateBloc>();
    boilerPlateBloc.add(GetError());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: buildDrawer(context),
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('HomePage'),
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
                  return buildInitialInput();
                } else if (state is BoilerPlateFetching) {
                  return buildLoading();
                } else if (state is BoilerPlateCompleted) {
                  return buildListViewData(state.users);
                } else {
                  return buildInitialInput();
                }
              },
            ),
          ),
        ));
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              color: Colors.indigo,
              height: 130,
              width: double.maxFinite,
            ),
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text('Get Local Users'),
            leading: Icon(Icons.local_fire_department_sharp),
            onTap: () async => await sendLocalToBloC(context),
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text('Get RemoteUsers'),
            onTap: () async => await sendRemoteToBloC(context),
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.error_outline),
            title: Text('Send Error'),
            onTap: () async => await sendErrorToBloC(context),
          ),
        ],
      ));
  }

  Widget buildInitialInput() {
    return Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.indigo),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildListViewData(List<User> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              users[index].name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            leading: Text(
              users[index].id.toString(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
            ),
          );
        });
  }
}



