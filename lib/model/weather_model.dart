library weather_model;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:weather_app/model/serializers.dart';

part 'weather_model.g.dart';

abstract class WeatherResponse implements Built<WeatherResponse, WeatherResponseBuilder> {
  WeatherResponse._();

  factory WeatherResponse([updates(WeatherResponseBuilder b)]) = _$WeatherResponse;

  @BuiltValueField(wireName: 'cod')
  String get cod;
  @BuiltValueField(wireName: 'message')
  int get message;
  @BuiltValueField(wireName: 'cnt')
  int get cnt;
  @BuiltValueField(wireName: 'list')
  BuiltList<Lists> get list;
  @BuiltValueField(wireName: 'city')
  City get city;
  String toJson() {
    return json.encode(serializers.serializeWith(WeatherResponse.serializer, this));
  }

  static WeatherResponse? fromJson(String jsonString) {
    return serializers.deserializeWith(WeatherResponse.serializer, json.decode(jsonString));
  }

  static Serializer<WeatherResponse> get serializer => _$weatherResponseSerializer;
}

abstract class Lists implements Built<Lists, ListsBuilder> {
  Lists._();

  factory Lists([updates(ListsBuilder b)]) = _$Lists;

  @BuiltValueField(wireName: 'dt')
  int get dt;
  @BuiltValueField(wireName: 'main')
  Main get main;
  @BuiltValueField(wireName: 'weather')
  BuiltList<Weather> get weather;
  @BuiltValueField(wireName: 'clouds')
  Clouds get clouds;
  @BuiltValueField(wireName: 'wind')
  Wind get wind;
  @BuiltValueField(wireName: 'visibility')
  int get visibility;
  @BuiltValueField(wireName: 'pop')
  double get pop;
  @BuiltValueField(wireName: 'rain')
  Rain get rain;
  @BuiltValueField(wireName: 'sys')
  Sys get sys;
  @BuiltValueField(wireName: 'dt_txt')
  String get dtTxt;
  String toJson() {
    return json.encode(serializers.serializeWith(Lists.serializer, this));
  }

  static Lists? fromJson(String jsonString) {
    return serializers.deserializeWith(Lists.serializer, json.decode(jsonString));
  }

  static Serializer<Lists> get serializer => _$listsSerializer;
}

abstract class Main implements Built<Main, MainBuilder> {
  Main._();

  factory Main([updates(MainBuilder b)]) = _$Main;

  @BuiltValueField(wireName: 'temp')
  double get temp;
  @BuiltValueField(wireName: 'feels_like')
  double get feelsLike;
  @BuiltValueField(wireName: 'temp_min')
  double get tempMin;
  @BuiltValueField(wireName: 'temp_max')
  double get tempMax;
  @BuiltValueField(wireName: 'pressure')
  int get pressure;
  @BuiltValueField(wireName: 'sea_level')
  int get seaLevel;
  @BuiltValueField(wireName: 'grnd_level')
  int get grndLevel;
  @BuiltValueField(wireName: 'humidity')
  int get humidity;
  // @BuiltValueField(wireName: 'temp_kf')
  // int get tempKf;

  String toJson() {
    return json.encode(serializers.serializeWith(Main.serializer, this));
  }

  static Main? fromJson(String jsonString) {
    return serializers.deserializeWith(Main.serializer, json.decode(jsonString));
  }

  static Serializer<Main> get serializer => _$mainSerializer;
}

abstract class Weather implements Built<Weather, WeatherBuilder> {
  Weather._();

  factory Weather([updates(WeatherBuilder b)]) = _$Weather;

  @BuiltValueField(wireName: 'id')
  int get id;
  @BuiltValueField(wireName: 'main')
  String get main;
  @BuiltValueField(wireName: 'description')
  String get description;
  @BuiltValueField(wireName: 'icon')
  String get icon;

  String toJson() {
    return json.encode(serializers.serializeWith(Weather.serializer, this));
  }

  static Weather? fromJson(String jsonString) {
    return serializers.deserializeWith(Weather.serializer, json.decode(jsonString));
  }

  static Serializer<Weather> get serializer => _$weatherSerializer;
}

abstract class Clouds implements Built<Clouds, CloudsBuilder> {
  Clouds._();

  factory Clouds([updates(CloudsBuilder b)]) = _$Clouds;

  @BuiltValueField(wireName: 'all')
  int get all;

  String toJson() {
    return json.encode(serializers.serializeWith(Clouds.serializer, this));
  }

  static Clouds? fromJson(String jsonString) {
    return serializers.deserializeWith(Clouds.serializer, json.decode(jsonString));
  }

  static Serializer<Clouds> get serializer => _$cloudsSerializer;
}

abstract class Wind implements Built<Wind, WindBuilder> {
  Wind._();

  factory Wind([updates(WindBuilder b)]) = _$Wind;

  @BuiltValueField(wireName: 'speed')
  double get speed;
  @BuiltValueField(wireName: 'deg')
  int get deg;
  @BuiltValueField(wireName: 'gust')
  double get gust;

  String toJson() {
    return json.encode(serializers.serializeWith(Wind.serializer, this));
  }

  static Wind? fromJson(String jsonString) {
    return serializers.deserializeWith(Wind.serializer, json.decode(jsonString));
  }

  static Serializer<Wind> get serializer => _$windSerializer;
}

abstract class Rain implements Built<Rain, RainBuilder> {
  Rain._();

  factory Rain([updates(RainBuilder b)]) = _$Rain;

  @BuiltValueField(wireName: '3h')
  double? get h;

  String toJson() {
    return json.encode(serializers.serializeWith(Rain.serializer, this));
  }

  static Rain? fromJson(String jsonString) {
    return serializers.deserializeWith(Rain.serializer, json.decode(jsonString));
  }

  static Serializer<Rain> get serializer => _$rainSerializer;
}

abstract class Sys implements Built<Sys, SysBuilder> {
  Sys._();

  factory Sys([updates(SysBuilder b)]) = _$Sys;

  @BuiltValueField(wireName: 'pod')
  String get pod;

  String toJson() {
    return json.encode(serializers.serializeWith(Sys.serializer, this));
  }

  static Sys? fromJson(String jsonString) {
    return serializers.deserializeWith(Sys.serializer, json.decode(jsonString));
  }

  static Serializer<Sys> get serializer => _$sysSerializer;
}

abstract class City implements Built<City, CityBuilder> {
  City._();

  factory City([updates(CityBuilder b)]) = _$City;

  @BuiltValueField(wireName: 'id')
  int get id;
  @BuiltValueField(wireName: 'name')
  String get name;
  @BuiltValueField(wireName: 'coord')
  Coord get coord;
  @BuiltValueField(wireName: 'country')
  String get country;
  @BuiltValueField(wireName: 'population')
  int get population;
  @BuiltValueField(wireName: 'timezone')
  int get timezone;
  @BuiltValueField(wireName: 'sunrise')
  int get sunrise;
  @BuiltValueField(wireName: 'sunset')
  int get sunset;
  String toJson() {
    return json.encode(serializers.serializeWith(City.serializer, this));
  }

  static City? fromJson(String jsonString) {
    return serializers.deserializeWith(City.serializer, json.decode(jsonString));
  }

  static Serializer<City> get serializer => _$citySerializer;
}

abstract class Coord implements Built<Coord, CoordBuilder> {
  Coord._();

  factory Coord([updates(CoordBuilder b)]) = _$Coord;

  @BuiltValueField(wireName: 'lat')
  double get lat;
  @BuiltValueField(wireName: 'lon')
  double get lon;

  String toJson() {
    return json.encode(serializers.serializeWith(Coord.serializer, this));
  }

  static Coord? fromJson(String jsonString) {
    return serializers.deserializeWith(Coord.serializer, json.decode(jsonString));
  }

  static Serializer<Coord> get serializer => _$coordSerializer;
}
