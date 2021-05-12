import 'package:boilerplate/features/boilerplate_app/data/datasource/boilerplate_local_json.dart';
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'package:boilerplate/features/boilerplate_app/domain/repositories/boiler_plate_repository.dart' ;
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
   HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('HomePage'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () async {
               await sendValueToBloC(context);
                }),
          ],
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
                    // (state is WeatherError)
                    return buildInitialInput();
                  }
                },
              ),),
        ));
  }

   Widget buildInitialInput() {
     return Center(
       child: Text('Home Page',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 23),),
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
         itemBuilder: (context,index){
         return ListTile(
           title: Text(users[index].name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
           leading: Text(users[index].id.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 23),),
         );
         });
   }
}


  void sendValueToBloC(BuildContext context) {
    var boilerPlateBloc = context.read<BoilerPlateBloc>();
   boilerPlateBloc.add(GetLocalUsers());
  }


