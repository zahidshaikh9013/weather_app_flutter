// ignore_for_file: must_be_immutable

part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final WeatherResponse? weatherResponse;

  const HomeLoadedState({this.weatherResponse});

  @override
  List<Object?> get props => [weatherResponse];
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  const HomeErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
