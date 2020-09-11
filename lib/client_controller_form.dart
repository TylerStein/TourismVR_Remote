import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientControllerForm extends StatelessWidget {
  final Function(int) playVideoById;
  final Function() disconnect;

  ClientControllerForm({
    @required this.playVideoById,
    @required this.disconnect,
  }) {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Text('Video Player'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
              child: Text('Play Video 1'),
              onPressed: () {
                playVideoById(1);
              },
            ),
          ],
        ),
        Spacer(),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
          child: Text('Disconnect'),
          onPressed: () {
            disconnect();
          },
        ),
        Spacer(),
      ],
    );
  }
}