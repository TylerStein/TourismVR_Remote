import 'package:flutter/foundation.dart';

@immutable
class VideoModel {
  final num id;
  final String name;
  final String location;
  final num durationSeconds;
  final DateTime uploadDate;
  final String fileName;

  VideoModel({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.durationSeconds,
    @required this.uploadDate,
    @required this.fileName,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
    VideoModel(
      id: json['id'] ?? null,
      name: json['name'] ?? null,
      location: json['location'] ?? null,
      durationSeconds: json['durationSeconds'] ?? null,
      uploadDate: DateTime.tryParse(json['uploadDate']),
      fileName: json['fileName'] ?? null,
    );
}