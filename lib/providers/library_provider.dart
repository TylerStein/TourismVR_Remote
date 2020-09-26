import 'dart:io';

import 'package:TourismVR_Remote/models/video_model.dart';
import 'package:TourismVR_Remote/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class LibraryAPIProvider extends ChangeNotifier {
  AuthAPIProvider authAPIProvider;
  List<VideoModel> _videos = [];

  List<VideoModel> get videos => List.unmodifiable(_videos);

  LibraryAPIProvider({
    @required this.authAPIProvider,
  });

  Future<bool> loadVideos() async {
    // if (!authAPIProvider.isAuthorized) {
    //   print('[APIProvider] Client must be authenticated before making requests');
    //   return false;
    // }

    String url = 'http://192.168.2.16:9000/v1/library';
    try {
      Response response = await Dio().get(
        url,
        options: Options(
          // headers: { 'authorization': authAPIProvider.token },
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        Iterable<dynamic> data = response.data as Iterable<dynamic>;
        List<Map<String, dynamic>> mapList = data.map((value) => Map<String, dynamic>.from(value)).toList();
        List<VideoModel> videoList = mapList.map((value) => VideoModel.fromJson(value)).toList();

        _videos = videoList;
        notifyListeners();
      } else {
        print('[APIProvider] Failed to obtain library videos with code ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }

    return true;
  }
}