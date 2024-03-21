import 'package:flutter/material.dart';
import 'package:gestionary/providers/statisticprovider.dart';
import 'package:gestionary/routes/splash_screen.dart';
import 'package:gestionary/screens/auth/login.dart';
import 'package:gestionary/providers/authprovider.dart';
import 'package:gestionary/providers/userprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserInfosProvider()),
        ChangeNotifierProvider(create: (context) => StatisticsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<String?>(
            future: provider.token(),
            builder: (context, snapshot) {
              final token = snapshot.data;
              if (token != null && token.isNotEmpty ) {
                return const SplashScreen();
              } else {
                return const MyLogin();
              }
            },
          );
        },
      ),
    );
  }
}
