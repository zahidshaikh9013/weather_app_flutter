import 'dart:convert';
import 'dart:developer';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/weather_model.dart';

class DatastoreCubit extends HydratedCubit<String> {
  DatastoreCubit() : super("");

  void loadData(String dataModel) {
    emit(dataModel);
  }

  @override
  String? fromJson(Map<String, dynamic> json) {
    return jsonEncode(json);
  }

  @override
  Map<String, dynamic> toJson(String? state) {
    return jsonDecode(state!);
  }
}
