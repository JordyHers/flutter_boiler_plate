import 'package:boilerplate/features/boilerplate_app/domain/repositories/boiler_plate_repository.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/pages/home_page.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/pages/tab_bar_items_page.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';



Future<void> pumpTabItemPage(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: ChangeNotifierProvider(
      create: (_)=> BoilerPlateProvider(),
      child: BlocProvider(
        create: (context) => BoilerPlateBloc(BoilerPlateRep()),
        child: ChangeNotifierProvider(create : (_) => BoilerPlateProvider(),child: HomePage()),
      ),
    ),
  ));

  await tester.pump();
}
void main() {
  testWidgets('test TabBarItemPage', (WidgetTester tester) async {
    await  pumpTabItemPage(tester);
    var scaffoldKey = Key('Scaffold_key');
    expect(find.byKey(scaffoldKey), findsOneWidget);
    final menu = find.byIcon(Icons.menu);
    expect(menu,findsOneWidget);

   // tester.tap(finder)
  });



}
