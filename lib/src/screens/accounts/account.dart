import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final AuthBloc _authBlox = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: _appBar(),
      body: _bodyBuilder(context),
    );
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "SNmayer",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _account(),
        Container(
          padding: EdgeInsets.all(50.0),
          child: StatusChart(),
        ),
        RaisedButton(onPressed: () {
          context.bloc<AuthBloc>().add(LoggedOut());
        }, child: Text('LogOut'))
      ],
    );
  }

  Widget _account() {
    return Container(
      color: Colors.black,
      height: 180.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _headingContainer(title: 'FOLLOWERS', num: 323),
              CircleAvatar(
                radius: 40.0,
                child: Text("SN"),
              ),
              _headingContainer(title: 'FOLLOWING', num: 29),
            ],
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "SNmayer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.explore,
                color: Colors.green,
                size: 15.0,
              ),
              Text(
                " EXPERIENCE ",
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "0",
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headingContainer({String title, int num}) {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$num',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
