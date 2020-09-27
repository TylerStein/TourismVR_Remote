import 'package:flutter/foundation.dart';

class APIResponse<T> {
  bool get isOk => error == null;
  T value;
  int code;
  Exception error;

  APIResponse({
    @required this.code,
    this.value,
    this.error,
  });
}