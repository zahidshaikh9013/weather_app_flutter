// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
//
// import 'package:weather_app/bloc_and_cubit/home_tab/home_cubit.dart';
//
// import '../main.dart';
//
// void main() {
//   testWidgets('MyHomePage has a button', (WidgetTester tester) async {
//     await tester.pumpWidget(MyApp());
//
//     final buttonFinder = find.byType(ElevatedButton);
//     expect(buttonFinder, findsOneWidget);
//   });
//
//   testWidgets('MyHomePage displays data', (WidgetTester tester) async {
//     await tester.pumpWidget(MyApp());
//
//     final cubit = tester.state<HomeCubit>(find.byType(HomeCubit));
//     cubit.emit(HomeState.HomeLoadedState('Data loaded successfully'));
//
//     await tester.pump();
//
//     final textFinder = find.text('Data loaded successfully');
//     expect(textFinder, findsOneWidget);
//   });
// }
