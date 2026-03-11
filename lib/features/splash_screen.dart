import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_bloc.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_state.dart';
import 'package:taghyeer_assessment/features/auth/presentation/auth_page.dart';
import 'package:taghyeer_assessment/features/main_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.wait([
      Future.delayed(const Duration(seconds: 1)),
      _waitForAuthResolution(),
    ]);

    if (!mounted) return;

    final state = context.read<AuthBloc>().state;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            state is AuthSuccess ? const MainScaffold() : const AuthPage(),
      ),
    );
  }

  Future<void> _waitForAuthResolution() async {
    final bloc = context.read<AuthBloc>();
    if (bloc.state is! AuthInitial && bloc.state is! AuthLoading) return;
    await bloc.stream.firstWhere(
      (state) => state is! AuthInitial && state is! AuthLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: FlutterLogo(size: 100)));
  }
}
