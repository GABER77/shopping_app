import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/nav_bar/nav_bar_cubit.dart';
import 'package:shopping_app/data/shared_preferences/cache_helper.dart';
import 'package:shopping_app/presentation/authentication_screens/login_screen.dart';
import 'package:shopping_app/presentation/boarding_screen/boarding_screen.dart';
import 'package:shopping_app/shared/constants/theme.dart';
import 'package:shopping_app/shared/core/nav_bar_layout.dart';
import 'business_logic/bloc/bloc_observer.dart';
import 'data/api_config/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeSettings();
  final Widget startScreen = await _determineStartScreen();

  runApp(MyApp(startScreen));
}

Future<void> _initializeSettings() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )
  );
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
}

Future<Widget> _determineStartScreen() async {
  final bool isBoardingComplete = CacheHelper.getData(key: 'isBoardingComplete') ?? false;
  final String? token = CacheHelper.getData(key: 'token');

  return isBoardingComplete
      ? (token != null ? const NavBarLayout() : LoginScreen())
      : const BoardingScreen();
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  const MyApp(this.startScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: ThemeMode.light,
            home: startScreen,
          );
        },
      ),
    );
  }
}