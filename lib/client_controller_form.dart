import 'package:TourismVR_Remote/api_provider.dart';
import 'package:TourismVR_Remote/websocket_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientControllerForm extends StatelessWidget {  
  final APIProvider apiProvider;
  final WebsocketProvider websocketProvider;

  ClientControllerForm({
    @required this.apiProvider,
    @required this.websocketProvider,
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
                apiProvider.playVideoById(1);
                websocketProvider.disconnect();
                websocketProvider.connect(WebsocketProvider.wsUrl, authToken: apiProvider.token);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
              child: Text('Play'),
              onPressed: () {
                websocketProvider.send('play', 'play');
              },
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
              child: Text('Stop'),
              onPressed: () {
                websocketProvider.send('stop', 'stop');
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
            websocketProvider.disconnect();
            apiProvider.disconnect();
          },
        ),
        Spacer(),
        StreamBuilder<String>(
          stream: websocketProvider?.wsStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Column(
              children: [
                Text('state: ${snapshot?.connectionState?.toString()}'),
                Text('data: ${snapshot?.data?.toString()}'),
                Text('error: ${snapshot?.error?.toString()}'),
              ],
            );
          },
        )
      ],
    );
  }
}