import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocfirebase/src/blocs/counter_bloc.dart';
import 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_bloc.dart';
import 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_event.dart';
import 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_state.dart';
import 'package:flutterblocfirebase/src/pages/stopwatch_with_global_state_page.dart';

import 'counter_with_global_state_page.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';

  void _pushPage(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final stopwatchBloc = BlocProvider.of<StopwatchBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<CounterBloc, int>(
          listener: (context, state) {
            if (state == 10) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text('Count: $state'),
                )
              );
            }
          }
        ),
        BlocListener<StopwatchBloc, StopwatchState>(
            listener: (context, state) {
              if (state.time.inMilliseconds == 10000) {
                if (!Navigator.of(context).canPop()) {
                  _pushPage(context, StopwatchWithGlobalStatePage.routeName);
                }
              }
            },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('BLoC example')),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Counter'),
              trailing: Chip(
                label: Text('Local State'),
                backgroundColor: Colors.blue[800],
              ),
              onTap: () => _pushPage(context, CounterWithLocalStatePage.routeName),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Counter'),
              subtitle: BlocBuilder<CounterBloc, int>(
                builder: (context, state) {
                  return Text('$state');
                },
              ),
              trailing: Chip(
                label: Text('Global State'),
                backgroundColor: Colors.green[800],
              ),
              onTap: () => _pushPage(context, CounterWithGlobalStatePage.routeName),
              onLongPress: () {
                counterBloc.dispatch(CounterEvent.increment);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Stopwatch'),
              trailing: Chip(
                label: Text('Local State'),
                backgroundColor: Colors.blue[800],
              ),
              onTap: () => _pushPage(context, StopwatchWithLocalStatePage.routeName),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Stopwatch'),
              subtitle: BlocBuilder<StopwatchBloc, StopwatchState>(
                builder: (context, state) {
                  return Text('${state.timeFormated}');
                },
              ),
              trailing: Chip(
                label: Text('Global State'),
                backgroundColor: Colors.green[800],
              ),
              onTap: () => _pushPage(context, StopwatchWithGlobalStatePage.routeName),
              onLongPress: () {
                if (stopwatchBloc.currentState.isRunning) {
                  stopwatchBloc.dispatch(StopStopwatch());
                } else {
                  stopwatchBloc.dispatch(StartStopwatch());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
