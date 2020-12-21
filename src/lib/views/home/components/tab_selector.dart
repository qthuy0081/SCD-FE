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
    return BottomNavigationBar(
      key: const Key('bottom_navigation'),
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        Icon icon;
        String text;
        switch (tab) {
          case AppTab.info:
            icon = new Icon(Icons.info);
            text = 'info';
            break;
          case AppTab.home:
            icon = new Icon(Icons.home);
            text = 'home';
            break;
          case AppTab.notify:
            icon = new Icon(Icons.notifications);
            text = 'notify';
            break;
        }
        return BottomNavigationBarItem(icon: icon, label: text);
      }).toList(),
    );
  }
}
