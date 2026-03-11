import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationTab { products, posts, settings }

class NavigationCubit extends Cubit<NavigationTab> {
  NavigationCubit() : super(NavigationTab.products);

  void navigateTo(NavigationTab tab) => emit(tab);

  int get currentIndex => NavigationTab.values.indexOf(state);
}
