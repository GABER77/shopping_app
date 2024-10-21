import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/data/shared_preferences/cache_helper.dart';
import 'package:shopping_app/presentation/authentication_screens/login_screen.dart';
import 'package:shopping_app/presentation/boarding_screen/boarding_screen.dart';
import 'package:shopping_app/presentation/home_screen/home_screen.dart';
import 'package:shopping_app/shared/constants/theme.dart';
import 'business_logic/bloc/bloc_observer.dart';
import 'data/api_config/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget startScreen;
  bool isBoardingComplete = CacheHelper.getData(key: 'isBoardingComplete') ?? false;
  String? token = CacheHelper.getData(key: 'token');
  if(isBoardingComplete){
    if(token != null) {
      startScreen = const HomeScreen();
    }
    else {
      startScreen = LoginScreen();
    }
  }
  else {
    startScreen = const BoardingScreen();
  }

  runApp(MyApp(startScreen));
}

class MyApp extends StatelessWidget {

  final Widget startScreen;
  MyApp(this.startScreen);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
    );
  }
}