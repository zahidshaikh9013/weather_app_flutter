// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/api_handler.dart';
import 'package:weather_app/services/request_const.dart';

import '../../model/weather_model.dart';
import '../hydrated_cubit/DataStore_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  Position? position;
  WeatherResponse? weatherResponse;

  Future<void> fetchUserLocationAndWeather(bool requestLocation) async {
    if (!requestLocation) return;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      position = await Geolocator.getCurrentPosition();
      debugPrint("User position: $position");
      await _getWeatherData(position!);
      emit(HomeLoadedState(weatherResponse: weatherResponse));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _getWeatherData(Position pos) async {
    try {
      String url =
          "${RequestConst().baseURL}/data/2.5/forecast?lat=${pos.latitude}&lon=${pos.longitude}&appid=37ea9939152496e5de6ca532f93817fd";
      debugPrint("Weather API URL: $url");

      var data = await DioHandler.getMethod(url: url);
      weatherResponse = WeatherResponse.fromJson(jsonEncode(data));
      DatastoreCubit().loadData(jsonEncode(data));

      debugPrint("Weather data: $data");
    } catch (e) {
      debugPrint("Failed to fetch weather data: $e");
      rethrow;
    }
  }
}
