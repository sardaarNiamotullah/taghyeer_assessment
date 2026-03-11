import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/core/cubit/navigation_cubit.dart';
import 'package:taghyeer_assessment/features/post/presentation/posts_tab.dart';
import 'package:taghyeer_assessment/features/products/presentation/products_tab.dart';
import 'package:taghyeer_assessment/features/settings/settings_tab.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  static const List<Widget> _tabs = [ProductsTab(), PostsTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //==========================
      // Body
      //==========================
      body: _tabs[context.watch<NavigationCubit>().currentIndex],

      //==========================
      // Nav bar
      //==========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<NavigationCubit>().currentIndex,
        onTap: (index) => context.read<NavigationCubit>().navigateTo(
          NavigationTab.values[index],
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
