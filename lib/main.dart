import 'package:flutter/material.dart';
import 'package:flutterblocfirebase/src/bloc/MyBlocDelegate.dart';
import 'package:flutterblocfirebase/src/bloc/bloc_supervisor.dart';
import 'package:flutterblocfirebase/src/blocs/counter_bloc.dart';
import 'package:flutterblocfirebase/src/blocs/stopwatch_bloc.dart';
import 'package:flutterblocfirebase/src/flutter_bloc/bloc_provider.dart';
import 'package:flutterblocfirebase/src/flutter_bloc/bloc_provider_tree.dart';
import 'package:flutterblocfirebase/src/pages/counter_with_global_state_page.dart';
import 'package:flutterblocfirebase/src/pages/home_page.dart';
import 'package:flutterblocfirebase/src/pages/stopwatch_with_global_state_page.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  runApp(BlocProviderTree(
    blocProviders: [
      BlocProvider<CounterBloc>(builder: (context) => CounterBloc(),),
      BlocProvider<StopwatchBloc>(builder: (context) => StopwatchBloc(),)
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        CounterWithLocalStatePage.routeName: (BuildContext context) => CounterWithLocalStatePage(),
        CounterWithGlobalStatePage.routeName: (BuildContext context) => CounterWithGlobalStatePage(),
        StopwatchWithGlobalStatePage.routeName: (BuildContext context) => StopwatchWithGlobalStatePage(),
        StopwatchWithLocalStatePage.routeName: (BuildContext context) => StopwatchWithLocalStatePage()
      },
    ),
  ));
}
