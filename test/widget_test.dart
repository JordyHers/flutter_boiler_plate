// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:boilerplate/features/boilerplate_app/domain/entities/model_provider.dart';
import 'package:boilerplate/features/boilerplate_app/domain/repositories/boiler_plate_repository.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Future<void> pumpHomePage(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: ChangeNotifierProvider(
      create: (_)=> UserClass(),
      child: BlocProvider(
        create: (context) => BoilerPlateBloc(BoilerPlateRep(UserClass()),context),
        child: HomePage(),
      ),
    ),
  ));

  await tester.pump();
}

void main() async {


    testWidgets('Test to display Home Page', (WidgetTester tester) async {
      await pumpHomePage(tester);
      expect(find.text('Home Page'), findsOneWidget);


    });

    testWidgets('If scaffold appears', (WidgetTester tester) async {
      await pumpHomePage(tester);
      var scaffoldKey = Key('Scaffold_key');
      expect(find.byKey(scaffoldKey),findsOneWidget);

    });


}
