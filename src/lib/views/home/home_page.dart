import 'package:flutter/material.dart';
import 'package:src/blocs/app_tab/apptab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/views/home/components/home_tab.dart';
import 'package:src/views/home/components/tab_selector.dart';
import 'components/info_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppTabBloc, AppTab>(
      builder: (context, state) {
        return Scaffold(
          body: tabContent(state),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addPhoto');
            },
            tooltip: 'Add photos',
            child: Icon(Icons.add_a_photo),
            backgroundColor: Colors.orange,
          ),
          bottomNavigationBar: TabSelector(
              activeTab: state,
              onTabSelected: (tab) =>
                  {BlocProvider.of<AppTabBloc>(context).add(TabUpdated(tab))}),
        );
      },
    );
  }

  tabContent(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment(0.3, 0),
                  tileMode: TileMode.repeated,
                  colors: [
                    Colors.red,
                    Colors.orange,
                  ],
                ),
              ),
            ),
            HomeTab(),
          ],
        );
        break;
      case AppTab.info:
        return InfoTab();
        break;
      case AppTab.notify:
        return Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment(0.3, 0),
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.red,
                Colors.orange,
              ],
            ),
          ),
        );
        break;
      default:
    }
  }
}
