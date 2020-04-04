import 'package:flutter/material.dart';
import 'package:flutterblocfirebase/src/bloc/MyBlocDelegate.dart';
import 'package:flutterblocfirebase/src/bloc/bloc_supervisor.dart';
import 'package:flutterblocfirebase/src/page/home_page.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: HomePage()
  ));
}
