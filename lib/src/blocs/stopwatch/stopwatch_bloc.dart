import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_event.dart';
import 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_state.dart';

export 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_event.dart';
export 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  int _elapsetTimeInMilliseconds = 0;

  StreamSubscription _streamPeriodicSubscription;

  @override
  void dispose() {
    _streamPeriodicSubscription?.cancel();
    _streamPeriodicSubscription = null;
    super.dispose();
  }

  @override
  StopwatchState get initialState => StopwatchState.initial();

  @override
  Stream<StopwatchState> mapEventToState(StopwatchEvent event) async* {
    if (event is StartStopwatch) {
      yield* _mapStartStopwatchToState();
    } else if (event is UpdateStopwatch) {
      yield* _mapUpdateStopwatchToState(event);
    } else if (event is StopStopwatch) {
      yield* _mapStopStopwatchToState();
    } else if (event is ResetStopwatch) {
      yield* _mapResetStopwatchToState();
    }
  }

  Stream<StopwatchState> _mapStartStopwatchToState() async* {
    if(_streamPeriodicSubscription == null) {
      _streamPeriodicSubscription = Stream.periodic(Duration(milliseconds: 10)).listen(
              (_) {
            _elapsetTimeInMilliseconds += 10;
            dispatch(
                UpdateStopwatch(
                    Duration(milliseconds: _elapsetTimeInMilliseconds)
                )
            );
          }
      );
    }
  }

  Stream<StopwatchState> _mapUpdateStopwatchToState(
      UpdateStopwatch event
  ) async* {
    final bool isSpecial = event.time.inMilliseconds % 3000 == 0;

    yield StopwatchState(
        time: event.time,
        isInitial: false,
        isRunning: true,
        isSpecial: isSpecial
    );
  }

  Stream<StopwatchState> _mapStopStopwatchToState() async* {
    _streamPeriodicSubscription?.cancel();
    _streamPeriodicSubscription = null;

    yield currentState.copyWith(isRunning: false);
  }

  Stream<StopwatchState> _mapResetStopwatchToState() async* {
    _elapsetTimeInMilliseconds = 0;
    if (!currentState.isRunning) {
      yield StopwatchState.initial();
    }
  }

}


