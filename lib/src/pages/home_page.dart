import 'package:flutter/material.dart';
import 'package:flutterblocfirebase/src/blocs/counter_bloc.dart';
import 'package:flutterblocfirebase/src/flutter_bloc/bloc_builder.dart';
import 'package:flutterblocfirebase/src/flutter_bloc/bloc_provider.dart';

import 'counter_with_global_state_page.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';

  void _pushPage(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
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
            subtitle: BlocBuilder(
              bloc: counterBloc,
              builder: (BuildContext context, int state) {
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
        ],
      ),
    );
  }
}
