import 'package:facebilling/core/app_globals.dart';
import 'package:facebilling/core/const.dart';
import 'package:facebilling/core/preference_helper.dart';
import 'package:facebilling/data/models/login_model.dart';
import 'package:facebilling/ui/screens/masters/home/home_page.dart';
import 'package:flutter/material.dart';

import 'ui/screens/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the saved token before launching the app
  String? token = await SharedPreferenceHelper.getToken();
  User? user = await SharedPreferenceHelper.getUser();
  // Ensure token is not null (set empty string if null)
  globalToken.value = token ?? "";
  if (user != null) {
    userId.value = user.userCode;
  }

  print("🔑 Loaded token: ${globalToken.value}");

  runApp(const MyApp());
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
      title: 'Billing Application',
      routes: {
        '/login': (context) => const WebmailLoginScreen(),
        '/home': (context) => const HomePage(),
      },
      home: const StartScreen(), // ✅ Root that decides which screen to show
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Safe check: handle both null & empty token
    final token = globalToken.value;
    final isLoggedIn = token != null && token.isNotEmpty;

    return isLoggedIn ? const HomePage() : const WebmailLoginScreen();
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