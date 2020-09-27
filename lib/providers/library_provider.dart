import 'dart:async';
import 'dart:io';

import 'package:TourismVR_Remote/models/api_response.dart';
import 'package:TourismVR_Remote/models/video_model.dart';
import 'package:TourismVR_Remote/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class LibraryAPIProvider extends ChangeNotifier {
  AuthAPIProvider authAPIProvider;
  APIResponse<List<VideoModel>> lastResponse;
  bool isLoading = false;

  LibraryAPIProvider({
    @required this.authAPIProvider,
  }) {
    //
  }

  Future<void> reload() async {
    // if (!authAPIProvider.isAuthorized) {
    //   print('[APIProvider] Client must be authenticated before making requests');
    //   return false;
    // }
    isLoading = true;
    notifyListeners();

    String url = 'http://192.168.2.16:9000/v1/library';
    try {
      Response response = await Dio().get(
        url,
        options: RequestOptions(
          // headers: { 'authorization': authAPIProvider.token },
          responseType: ResponseType.json,
          connectTimeout: 1000,
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        Iterable<dynamic> data = response.data as Iterable<dynamic>;
        List<Map<String, dynamic>> mapList = data.map((value) => Map<String, dynamic>.from(value)).toList();
        List<VideoModel> videoList = mapList.map((value) => VideoModel.fromJson(value)).toList();

        lastResponse = APIResponse<List<VideoModel>>(
          code: response.statusCode,
          value: videoList,
          error: null,
        );
      } else {
        String errorText = '[APIProvider] Failed to obtain library videos with code ${response.statusCode}';
        lastResponse = APIResponse<List<VideoModel>>(
          code: response.statusCode,
          error: Exception(errorText),
        );
        print(errorText);
      }

      // throw new Exception('Aaaaa');
    } catch (error) {
      String errorText = error.toString();
      lastResponse = APIResponse<List<VideoModel>>(
        code: 500,
        error: Exception(errorText),
      );
      print(errorText);
    }

    isLoading = false;
    notifyListeners();
  }
}