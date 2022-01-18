import 'package:flutter/material.dart';

enum TabItem { homePage, menu, account }

class TabItemData {
  const TabItemData({required this.title, required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.homePage: TabItemData(title: 'Home Page', icon: Icons.home_rounded),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
    TabItem.menu: TabItemData(title: 'Menu', icon: Icons.menu),
  };
}
