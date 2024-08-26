import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc_and_cubit/home_tab/home_cubit.dart';
import '../bloc_and_cubit/hydrated_cubit/DataStore_cubit.dart';
import '../model/weather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  late HomeCubit _homeCubit;
  List<ConnectivityResult> _connectionStatus = [];

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit();

    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        _updateConnectionStatus(result);
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) return;

    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus.first != ConnectivityResult.none) {
      _homeCubit.fetchUserLocationAndWeather(_connectionStatus.isNotEmpty &&
          _connectionStatus.first != ConnectivityResult.none);
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus.first != ConnectivityResult.none) {
      _homeCubit.fetchUserLocationAndWeather(_connectionStatus.isNotEmpty &&
          _connectionStatus.first != ConnectivityResult.none);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Demo")),
      body: BlocProvider<HomeCubit>(
        create: (context) => _homeCubit,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (_connectionStatus.isEmpty) {
              return const SizedBox();
            }

            if (_connectionStatus.first == ConnectivityResult.none) {
              var dataStoreCubit = BlocProvider.of<DatastoreCubit>(context);
              if (dataStoreCubit.state.isEmpty) {
                return const Center(child: Text("No data found"));
              } else {
                WeatherResponse? weatherResponse =
                    WeatherResponse.fromJson(dataStoreCubit.state);
                return commonDataList(weatherResponse, "Offline");
              }
            } else {
              if (state is HomeLoadedState) {
                return commonDataList(state.weatherResponse, "Online");
              } else if (state is HomeErrorState) {
                return Center(child: Text(state.errorMessage));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
          },
        ),
      ),
    );
  }

  commonDataList(WeatherResponse? weatherResponse, String connectionStatus) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Text(
            "$connectionStatus ",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 20,
          ),
          ...List.generate(
            weatherResponse!.list.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 100,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Temp:")),
                            Expanded(
                                flex: 4,
                                child: Text(
                                    "${weatherResponse.list[index].main.temp}")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Pressure:")),
                            Expanded(
                                flex: 4,
                                child: Text(
                                    "${weatherResponse.list[index].main.pressure}")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Clouds:")),
                            Expanded(
                                flex: 4,
                                child: Text(
                                    "${weatherResponse.list[index].clouds.all}")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Wind Speed:")),
                            Expanded(
                                flex: 4,
                                child: Text(
                                    "${weatherResponse.list[index].wind.speed}")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Wind deg:")),
                            Expanded(
                                flex: 4,
                                child: Text(
                                    "${weatherResponse.list[index].wind.deg}")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Rain:")),
                            Expanded(
                                flex: 4,
                                child: Text(
                                    "${weatherResponse.list[index].rain.h}")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Date:")),
                            Expanded(
                                flex: 4,
                                child: Text(DateFormat('dd/MM/yyyy hh:mm a')
                                    .format(DateTime.parse(
                                        weatherResponse.list[index].dtTxt)))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
