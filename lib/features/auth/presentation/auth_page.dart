import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_bloc.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_event.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_state.dart';
import 'package:taghyeer_assessment/features/main_scaffold.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainScaffold()),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Title
                    const Text(
                      'Welcome',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Login to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),

                    const SizedBox(height: 30),

                    /// Username
                    TextFormField(
                      controller: _usernameController,
                      autocorrect: false,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),

                    const SizedBox(height: 20),

                    /// Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),

                    const SizedBox(height: 40),

                    /// Login Button
                    if (state is AuthLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                username: _usernameController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
