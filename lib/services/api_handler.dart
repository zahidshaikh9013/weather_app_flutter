import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHandler {
  static String endPointUrl =
      "https://api.openweathermap.org/data/2.5/forecast?lat={userLat}&lon={userLng}&appid=37ea9939152496e5de6ca532f93817fd  ";

  static Future<dynamic> getMethod({required String url}) async {
    Dio d = dio.Dio();

    dio.Response response = await d.get(url);
    log("response.data--------------> ${response.data}");

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return response.data;
    }
  }
}
