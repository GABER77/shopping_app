import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/presentation/boarding_screen/boarding_screen.dart';
import 'package:shopping_app/shared/constants/theme.dart';
import 'business_logic/bloc/bloc_observer.dart';
import 'data/api_config/dio_helper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BoardingScreen(),
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}