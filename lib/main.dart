import 'package:TourismVR_Remote/api_provider.dart';
import 'package:TourismVR_Remote/auth_code_form.dart';
import 'package:TourismVR_Remote/client_controller_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TourismVR Controller'),
      ),
      body: ChangeNotifierProvider<APIProvider>(
        create: (BuildContext context) => APIProvider(),
        child: Center(
          child: Consumer<APIProvider>(
            builder: _buildBody,
          )
        )
      ),
    );
  }

  Widget _buildBody(BuildContext context, APIProvider provider, Widget child) {
    if (provider.isAuthorized) {
      return ClientControllerForm(
        playVideoById: (int videoId) => provider.playVideoById(videoId),
        disconnect: () => provider.disconnect(),
      );
    } else {
      return AuthCodeForm(
        onSubmit: (String token) => provider.authenticate(token),
      );
    }
  }
}