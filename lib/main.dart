import 'package:facebilling/core/app_globals.dart';
import 'package:facebilling/core/preference_helper.dart';
import 'package:facebilling/ui/screens/masters/home/home_page.dart';
import 'package:flutter/material.dart';

import 'ui/screens/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the saved token before launching the app
  await SharedPreferenceHelper.getToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
  navigatorKey: navigatorKey, // ✅ Add this line
  debugShowCheckedModeBanner: false,
  title: 'Face Billing App',
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  initialRoute: '/login',
  routes: {
    '/login': (context) => const WebmailLoginScreen(),
    '/home': (context) => const HomePage(),
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