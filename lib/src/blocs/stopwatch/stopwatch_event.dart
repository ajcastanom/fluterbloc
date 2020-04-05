import 'package:equatable/equatable.dart';

abstract class StopwatchEvent extends Equatable {}

class StartStopwatch extends StopwatchEvent {
  @override
  List<Object> get props => null;
}

class StopStopwatch extends StopwatchEvent {
  @override
  List<Object> get props => null;
}

class ResetStopwatch extends StopwatchEvent {
  @override
  List<Object> get props => null;
}

class UpdateStopwatch extends StopwatchEvent {
  final Duration time;

  UpdateStopwatch(this.time);

  @override
  List<Object> get props => [time];

  @override
  String toString() => 'UpdateStopwatch {timeInMilliseconds: ${time.inMilliseconds}}';
}
