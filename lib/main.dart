import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/controllers/note_cubit/note_cubit.dart';
import 'package:note_app/core/managers/app_strings.dart';
import 'package:note_app/core/themes/theme_date/theme_date_light.dart';
import 'core/controllers/blocObserver.dart';
import 'core/screens/modules/home_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCubit>(
      create: (context) => NoteCubit()..readDatabase(),
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
