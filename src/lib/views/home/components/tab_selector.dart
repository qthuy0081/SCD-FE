import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:src/blocs/app_tab/apptab_bloc.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      key: const Key('bottom_navigation'),
      theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.orange[900],
          selectedItemBackgroundColor: Colors.orange[900],
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.orange[900],
        ),
      selectedIndex: AppTab.values.indexOf(activeTab),
      onSelectTab: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        IconData icon;
        String text;
        switch (tab) {
          case AppTab.info:
            icon = Icons.info;
            text = 'info';
            break;
          case AppTab.home:
            icon = Icons.home;
            text = 'home';
            break;
          case AppTab.notify:
            icon = Icons.notifications;
            text = 'notify';
            break;
        }
        return FFNavigationBarItem(iconData: icon, label: text);
      }).toList(),
    );
  }
}
