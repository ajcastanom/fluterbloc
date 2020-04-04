import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

abstract class Bloc<Event, State> {
  final PublishSubject<Event> _eventSubject = PublishSubject<Event>();
  BehaviorSubject<State> _stateSubject;

  State get initialState;

  State get currentState => _stateSubject.value;

  Stream<State> get state => _stateSubject.stream;

  Bloc() {
    _stateSubject = BehaviorSubject<State>.seeded(initialState);
    _bindStateSubject();
  }

  @mustCallSuper
  void dispose() {
    _eventSubject.close();
    _stateSubject.close();
  }

  void onError(Object error, StackTrace stackTrace) => null;

  void onEvent(Event event) => null;

  void dispatch(Event event) {
    try {
      onEvent(event);
      _eventSubject.sink.add(event);
    } catch (e) {
      _handleError(e);
    }
  }

  Stream<State> transform(
    Stream<Event> events,
    Stream<State> next(Event event)
  ) {
    return events.asyncExpand(next);
  }

  Stream<State> mapEventToState(Event event);

  void _bindStateSubject() {
    transform(
      _eventSubject,
      (Event event) {
        return mapEventToState(event).handleError(_handleError);
      }
    ).forEach(
        (State nextState) {
          if(currentState == nextState || _stateSubject.isClosed) return;
          _stateSubject.sink.add(nextState);
        }
    );
  }

  void _handleError(Object error, [StackTrace stackTrace]) {
    onError(error, stackTrace);
  }
}

