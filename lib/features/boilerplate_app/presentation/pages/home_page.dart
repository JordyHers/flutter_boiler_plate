import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:boilerplate/features/boilerplate_app/domain/entities/model_provider.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  UserClass _userClass= UserClass();
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

  ///Methods To send ERROR to Bloc
  void _delete(BoilerPlateProvider user,BuildContext context) {
    if(user.userList.length != 0){
      user.userList.removeLast();
      print('the length of the list is : ${user.userList.length}');
    } else if (user.userList.length == 0){
      var boilerPlateBloc = context.read<BoilerPlateBloc>();
      boilerPlateBloc.add(GetInitialInput());
    }



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
                  return buildInitialInput(context);
                } else if (state is BoilerPlateFetching) {
                  return buildLoading();
                } else if (state is BoilerPlateCompleted) {
                  return buildListViewData(state.users);
                }else if (state is BoilerPlateProvider) {
                  return buildProviderView(context);
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
              onTap: () async => await sendLocalToBloC(context),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.computer),
              title: Text('Get RemoteUsers'),
              onTap: () async => await sendRemoteToBloC(context),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.error_outline),
              title: Text('Send Error'),
              onTap: () async => await sendErrorToBloC(context),
            ), SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.compass_calibration_sharp),
              title: Text('Notifier Provider'),

              onTap: () async => await sendProviderToBloC(context),
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
                    //TODO: DISMISS THE DISMISSABLE
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (_)=> _delete(user,context),
                        child: ListTile(
                          title: Text(user.userList[index].name),
                          subtitle: Text(user.userList[index].email),
                          leading: Icon(Icons.person),
                        ),
                      );
                    }

                )),
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
