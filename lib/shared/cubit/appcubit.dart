import 'package:bloc/bloc.dart';

import 'appstate.dart';

class appCubit extends Cubit<appStates> {
  appCubit():super(appintialstate());

}