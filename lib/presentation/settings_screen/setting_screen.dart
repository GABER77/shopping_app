import 'package:flutter/material.dart';
import '../../data/shared_preferences/cache_helper.dart';
import '../../shared/core/navigation.dart';
import '../authentication_screens/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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