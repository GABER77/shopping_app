import 'package:flutter/material.dart';
import 'package:shopping_app/data/shared_preferences/cache_helper.dart';
import 'package:shopping_app/presentation/authentication_screens/login_screen.dart';
import 'package:shopping_app/shared/core/navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            CacheHelper.removeData(key: 'token').then((value) {
              if(value) navigateToAndClose(context, LoginScreen());
            });
          },
          child: const Text(
            'Sign out',
          ),
        ),
      ),
    );
  }
}
