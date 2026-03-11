import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/core/cubit/navigation_cubit.dart';
import 'package:taghyeer_assessment/core/theme/theme.dart';
import 'package:taghyeer_assessment/core/theme/theme_cubit.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_bloc.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_event.dart';
import 'package:taghyeer_assessment/features/auth/repo/auth_repo.dart';
import 'package:taghyeer_assessment/features/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(
          create: (_) => AuthBloc(AuthRepo())..add(AuthCheckCacheRequested()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
