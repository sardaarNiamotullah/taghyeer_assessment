import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/core/theme/theme_cubit.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDark;
    return Column(
      children: [
        const SizedBox(height: 200),
        Row(
          mainAxisAlignment: .center,
          children: [
            CircleAvatar(radius: 45),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text('username'),
                Text('Name'),
                Text('username@gamil.com'),
              ],
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode, size: 45),
              tooltip: isDark ? 'Switch to Light' : 'Switch to Dark',
            ),
          ],
        ),
      ],
    );
  }
}
