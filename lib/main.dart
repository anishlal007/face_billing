import 'dart:ui_web';

import 'package:facebilling/core/app_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:facebilling/core/route_manager.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   setUrlStrategy(const HashUrlStrategy()); // ✅ Keeps /#/home for web

//   runApp(const MyApp());
// }
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(const HashUrlStrategy());

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Center(
      child: Text(
        details.exceptionAsString(),
        style: const TextStyle(color: Colors.red),
      ),
    );
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final RouteObserver<ModalRoute<void>> routeObserver =
        RouteObserver<ModalRoute<void>>();

    return MaterialApp(
      navigatorObservers: [routeObserver],
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Face Billing Application',
      onGenerateRoute: RouteManager.generateRoute,
      initialRoute: '/', // Root always goes to StartScreen
      routes: {
        '/': (context) => const StartScreen(),
      },
    );
  }
}



// import 'package:facebilling/core/preference_helper.dart';
// import 'package:facebilling/ui/screens/masters/home/home_page.dart';
// import 'package:facebilling/ui/screens/pages/login_page.dart';
// import 'package:flutter/material.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Load saved token
//   final token = await SharedPreferenceHelper.getToken();

//   runApp(MyApp(initialToken: token));
// }

// class MyApp extends StatelessWidget {
//   final String? initialToken;
//   const MyApp({super.key, this.initialToken});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Inventory System',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: initialToken != null && initialToken!.isNotEmpty
//           ? const HomePage()       // Token exists → go to HomePage
//           : const WebmailLoginScreen(), // No token → go to LoginPage
//     );
//   }
// }