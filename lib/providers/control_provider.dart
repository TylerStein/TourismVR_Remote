import 'dart:convert';
import 'dart:io';

import 'package:TourismVR_Remote/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ControlAPIProvider extends ChangeNotifier {
  AuthAPIProvider authAPIProvider;

  bool get isPaired => authAPIProvider.isAuthorized;

  ControlAPIProvider({
    @required this.authAPIProvider,
  });

  Future<bool> playVideoById(int id) async {
    if (!authAPIProvider.isAuthorized) {
      print('[APIProvider] Client must be authenticated before making requests');
      return false;
    }

    String url = 'http://192.168.2.16:9000/v1/remote/play/$id';
    String data = jsonEncode({ 'file': id });
    try {
      Response response = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: { 'authorization': authAPIProvider.token },
          contentType: 'application/json',
        ),
      );

      return response.statusCode == HttpStatus.ok;
    } catch (error) {
      print(error);
      return false;
    }
  }
}