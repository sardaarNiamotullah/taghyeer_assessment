import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/core/theme/theme_cubit.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_bloc.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_event.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_state.dart';
import 'package:taghyeer_assessment/features/auth/presentation/auth_page.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDark;
    final authState = context.watch<AuthBloc>().state;
    if (authState is! AuthSuccess) return const SizedBox.shrink();
    final user = authState.user;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Profile Avatar
            CircleAvatar(radius: 60, backgroundImage: NetworkImage(user.image)),

            const SizedBox(height: 20),

            /// Username
            Text('@${user.username}', style: const TextStyle(fontSize: 14)),

            const SizedBox(height: 6),

            /// Full Name
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            /// Email
            Text(user.email, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 40),

            /// Theme Toggle
            IconButton(
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode, size: 40),
              tooltip: isDark ? 'Switch to Light' : 'Switch to Dark',
            ),

            const SizedBox(height: 30),

            /// Logout
            ElevatedButton.icon(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const AuthPage()),
                  (_) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
