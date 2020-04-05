import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocfirebase/src/blocs/counter_bloc.dart';
import 'package:flutterblocfirebase/src/blocs/my_bloc_delegate.dart';
import 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_bloc.dart';
import 'package:flutterblocfirebase/src/pages/counter_with_global_state_page.dart';
import 'package:flutterblocfirebase/src/pages/home_page.dart';
import 'package:flutterblocfirebase/src/pages/stopwatch_with_global_state_page.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  runApp(MultiBlocProvider(
    providers: [
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
