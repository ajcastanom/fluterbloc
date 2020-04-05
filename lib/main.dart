import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterblocfirebase/src/blocs/my_bloc_delegate.dart';
import 'package:flutterblocfirebase/src/repositories/preferences_repository_impl.dart';

import 'src/app.dart';
import 'src/blocs/preferences/preferences_bloc.dart';

void main() {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = MyBlocDelegate();

  final preferencesRepository = PreferencesRepositoryImpl();
  final preferencesBloc = PreferencesBloc(preferencesRepository: preferencesRepository);

  preferencesBloc.state
    .firstWhere((state) => state is PreferencesLoaded)
    .then((_) => runApp(App(
      preferencesRepository: preferencesRepository,
      preferencesBloc: preferencesBloc,
    )));

  preferencesBloc.dispatch(LoadPreferences());
}
