import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketProvider extends ChangeNotifier {
  static const String wsUrl = 'ws://192.168.2.16:9090';

  IOWebSocketChannel _channel;
  StreamController<String> _streamController;

  Stream<String> get wsStream => _streamController.stream;

  WebsocketProvider() {
    _streamController = new StreamController.broadcast();
  }

  void connect(String url, { String authToken, bool notify = true }) {
    if (_channel != null) {
      disconnect();
    }

    Map<String, dynamic> headers = {};
    if (authToken != null) {
      headers['authorization'] = authToken;
    }

    _channel = IOWebSocketChannel.connect(url, headers: headers);
    _channel.stream.listen((value) {
      print('Stream value $value');
      _streamController.add('$value');
    });

    if (notify == true) notifyListeners();
  }

  void send(String event, String data) {
    if (_channel != null) {
      String jsonMessage = jsonEncode({ 'event': event, 'data': data });
      _channel.sink.add(jsonMessage);
    }
  }

  void disconnect({ bool notify = false }) {
    if (_channel != null) {
      _channel.sink.close();
      _channel = null;
      if (notify == true) notifyListeners();
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}