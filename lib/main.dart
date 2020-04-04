import 'package:flutter/material.dart';
import 'package:flutterblocfirebase/src/bloc/MyBlocDelegate.dart';
import 'package:flutterblocfirebase/src/bloc/bloc_supervisor.dart';
import 'package:flutterblocfirebase/src/blocs/counter_bloc.dart';
import 'package:flutterblocfirebase/src/pages/counter_with_global_state_page.dart';
import 'package:flutterblocfirebase/src/pages/home_page.dart';

import 'src/flutter_bloc/bloc_provider.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  final counterBloc = CounterBloc();

  runApp(BlocProvider<CounterBloc>(
    bloc: counterBloc,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        CounterWithLocalStatePage.routeName: (BuildContext context) => CounterWithLocalStatePage(),
        CounterWithGlobalStatePage.routeName: (BuildContext context) => CounterWithGlobalStatePage()
      },
    ),
  ));
}
