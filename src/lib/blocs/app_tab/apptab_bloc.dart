import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'apptab_event.dart';
part 'apptab_state.dart';

class AppTabBloc extends Bloc<TabEvent, AppTab> {
  AppTabBloc() : super(AppTab.info);

  @override
  Stream<AppTab> mapEventToState(
    TabEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is TabUpdated) {
      yield event.tab;
    }
  }
}
