import 'package:flutterblocfirebase/src/bloc/transition.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class BlocDelegate {
  @mustCallSuper
  void onEvent(Bloc bloc, Object event) => null;

  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) => null;

  @mustCallSuper
  void onError(Bloc bloc, Object error, StackTrace stackTrace) => null;
}
