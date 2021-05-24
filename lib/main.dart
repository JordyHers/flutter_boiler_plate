import 'package:boilerplate/features/boilerplate_app/domain/repositories/boiler_plate_repository.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'features/boilerplate_app/domain/entities/model_provider.dart';
import 'features/boilerplate_app/presentation/pages/tab_bar_items_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Provider<UserClass>(
        create: (_)=> UserClass(),
        child: BlocProvider(
          create: (_) => BoilerPlateBloc(BoilerPlateRep(),context),
          child: TabBarItemPage(),
        ),
      ),
    );
  }
}
