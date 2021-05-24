import 'package:boilerplate/features/boilerplate_app/domain/entities/model_provider.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/widgets/cupertino_home_scaffold.dart';
import 'package:boilerplate/features/boilerplate_app/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account_page.dart';
import 'home_page.dart';
import 'menu_page.dart';


class TabBarItemPage extends StatefulWidget {
  final BuildContext context;

  const TabBarItemPage({Key key, this.context}) : super(key: key);

  @override
  _TabBarItemPageState createState() => _TabBarItemPageState();
}

class _TabBarItemPageState extends State<TabBarItemPage> {
  TabItem _currentTab = TabItem.homePage;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.homePage: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
    TabItem.menu: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.homePage: (_) => HomePage(),
      TabItem.account: (context) => AccountPage(),
      TabItem.menu: (_) => MenuPage(),
    };
  }

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      //pop to first root
      /// This section allows the user to get back to the root when he presses the
      /// icon on the bottomNavigation bar
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// WillpopScope allow us to control the back button and hinders the users to exit the app when he
    /// just wants to get to the previous page
    return ChangeNotifierProvider(
      create: (_)=> UserClass(),
      child: WillPopScope(
          onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
          child: CupertinoHomeScaffold(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
            widgetBuilders: widgetBuilders,
            navigatorKeys: navigatorKeys,
          ),
      ),
    );

  }
}
