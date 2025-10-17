import 'package:facebilling/core/const.dart';
import 'package:flutter/material.dart';
import 'package:facebilling/ui/screens/pages/login_page.dart';
import 'package:facebilling/ui/screens/masters/home/home_page.dart';
import 'package:facebilling/core/app_globals.dart';
import 'package:facebilling/core/preference_helper.dart';

class RouteManager {
  static const String login = '/login';
  static const String home = '/home';
  static const String Addsupplier = '/add-supplier';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const WebmailLoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(builder: (_) => const StartScreen());
    }
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _loading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    // Read stored login details
    final token = await SharedPreferenceHelper.getToken();
    final user = await SharedPreferenceHelper.getUser();

    if (token != null && token.isNotEmpty) {
      globalToken.value = token;
      if (user != null) {
        userId.value = user.userCode.toString();
      }
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Once data is loaded, navigate accordingly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(
        _isLoggedIn ? RouteManager.home : RouteManager.login,
      );
    });

    // Temporary empty widget (won’t actually be shown)
    return const SizedBox.shrink();
  }
}
