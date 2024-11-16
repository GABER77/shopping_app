import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/business_logic/cubit/nav_bar/nav_bar_states.dart';
import 'package:shopping_app/presentation/cart_screen/cart_screen.dart';
import '../../../presentation/favorite_screen/favorite_screen.dart';
import '../../../presentation/primary_screen/primary_screen.dart';
import '../../../presentation/settings_screen/setting_screen.dart';

class NavBarCubit extends Cubit<NavBarStates> {
  NavBarCubit() : super(NavBarInitialState());

  static NavBarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isSearchActive  = false;

  List<Widget> screens = [
    const PrimaryScreen(),
    const CartScreen(),
    FavoriteScreen(),
    const SettingsScreen(),
  ];

  List<IconData> navBarIcons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.favorite,
    Icons.settings,
  ];

  void changeScreen(int index){
    currentIndex = index;
    emit(NavBarScreenChangeState());
  }

  void hideNavBar() {
    isSearchActive = true;
    emit(NavBarChangeVisibilityState());
  }

  void showNavBar() {
    isSearchActive = false;
    emit(NavBarChangeVisibilityState());
  }

}