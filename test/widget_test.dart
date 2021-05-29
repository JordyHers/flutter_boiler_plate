import 'package:boilerplate/features/boilerplate_app/domain/repositories/boiler_plate_repository.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/bloc/boiler_plate_bloc.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/pages/account_page.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/pages/home_page.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/pages/menu_page.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/pages/tab_bar_items_page.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/widgets/cupertino_home_scaffold.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';



Future<void> pumpHomePage(WidgetTester tester) async {
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

Future<void> pumpTabItemPage(WidgetTester tester) async {
  TabItem _currentTab = TabItem.homePage;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.homePage: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
    TabItem.menu: GlobalKey<NavigatorState>(),
  };



  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      //pop to first root
      /// This section allows the user to get back to the root when he presses the
      /// icon on the bottomNavigation bar
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      _currentTab = tabItem;
    }
  }
  await tester.pumpWidget(MaterialApp(
    home: ChangeNotifierProvider(
      create: (_)=> BoilerPlateProvider(),
      child: BlocProvider(
        create: (context) => BoilerPlateBloc(BoilerPlateRep()),
        child: CupertinoHomeScaffold(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
          widgetBuilders: widgetBuilders,
          navigatorKeys: navigatorKeys,
        ),
      ),
    ),
  ));
  await tester.pump();
}
Map<TabItem, WidgetBuilder> get widgetBuilders {
  return {
    TabItem.homePage: (_) => ChangeNotifierProvider(create : (_) => BoilerPlateProvider(),child: HomePage()),
    TabItem.account: (context) => AccountPage(),
    TabItem.menu: (_) => MenuPage(),
  };
}

void main() {


  testWidgets('test TabBarItemPage', (WidgetTester tester) async {
    await  pumpHomePage(tester);
    var scaffoldKey = Key('Scaffold_key');
    expect(find.byKey(scaffoldKey), findsOneWidget);


  });
  testWidgets('trigger Drawer', (WidgetTester tester)async {
    var containerKey = Key('Container_Key');
    await  pumpTabItemPage(tester);

    expect(find.byKey(containerKey), findsNothing);
    final menu = find.byIcon(Icons.menu);
    final account = find.byIcon(Icons.person);

    expect(menu,findsNothing);
    expect(account ,findsNothing);

    
  });



}
