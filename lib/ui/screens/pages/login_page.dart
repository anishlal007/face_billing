
import 'package:facebilling/core/const.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/preference_helper.dart';
import '../../../data/services/login_service.dart';
import '../masters/home/home_page.dart';

// You can define a constant for the main purple color

class WebmailLoginScreen extends StatefulWidget {
  const WebmailLoginScreen({super.key});

  @override
  State<WebmailLoginScreen> createState() => _WebmailLoginScreenState();
}

class _WebmailLoginScreenState extends State<WebmailLoginScreen> {


  @override
  Widget build(BuildContext context) {
    // LayoutBuilder checks the screen constraints (width)
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check if the screen is wide enough for the two-column layout (Web/Desktop)
            if (constraints.maxWidth > 600) {
              return _buildWebLayout(context);
            }
            // For narrower screens (Mobile/Tablet), use a single column
            else {
              return _buildMobileLayout(context);
            }
          },
        ),
      ),
    );
  }

  // --- WEB Layout (Two-Column) ---
  Widget _buildWebLayout(BuildContext context) {
    return Container(
      // The main card container for the web version
      constraints: const BoxConstraints(maxWidth: 800, maxHeight: 500),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color:black,
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Left Side (Branding/Purple Column)
          const Expanded(
            flex: 1,
            child: _PurplePanel(),
          ),
          // Right Side (Login Form)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: _WebmailLoginForm(),
            ),
          ),
        ],
      ),
    );
  }

  // --- MOBILE Layout (Single Column) ---
  Widget _buildMobileLayout(BuildContext context) {
    // The mobile view will have the form centered
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // The purple panel header for mobile (simplified for the form view)
            const SizedBox(height: 40),
            // The form itself
            _WebmailLoginForm(),
            const SizedBox(height: 40),
            // The terms and policy links (at the bottom)
            const _TermsAndPolicyLinks(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// --- COMMON WIDGETS ---

// The stateless widget for the login form elements
class _WebmailLoginForm extends StatefulWidget {
  const _WebmailLoginForm({super.key});

  @override
  State<_WebmailLoginForm> createState() => _WebmailLoginFormState();
}

class _WebmailLoginFormState extends State<_WebmailLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  bool _isLoading = false;

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final response = await _loginService.login(
      userId: _userIdController.text.trim(),
      userPassword: _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (response.data != null && response.data!.status == true) {
      // ✅ Save login data and token
      await SharedPreferenceHelper.setUser(response.data!.user!);
      await SharedPreferenceHelper.setToken(response.data!.token!);
      String? token=await SharedPreferenceHelper.getToken();
      globalToken.value=token;
      print("globalToken.value");
      print(globalToken.value);

      // ✅ Navigate to HomePage and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } else {
      // ❌ Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error ?? "Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Welcome To Billing App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
          const SizedBox(height: 30),

          TextFormField(
            controller: _userIdController,
            decoration: const InputDecoration(
              hintText: 'User Name',
              border: UnderlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter User Name' : null,
          ),
          const SizedBox(height: 20),

          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
              border: UnderlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter password' : null,
          ),
          const SizedBox(height: 40),
TextButton(
  onPressed: () {
   _userIdController.text = "admin";
   _passwordController.text = "B976ZUX5";
  },
  child: Text(
    'Click Me for Demo Login',
    style: TextStyle(
      fontSize: 12,
      color: primary,
    ),
  ),
),
 const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(color: white)
                : const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }
}
// Widget for the left purple panel on web/desktop
class _PurplePanel extends StatelessWidget {
  const _PurplePanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Stack(
        children: [
          // Placeholder for the logo (JD logo in the image)
          Center(
  child: Text(
    'FACE BILLING',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.w900,
      color: white,
    ),
  ),
)
,
          // Links at the bottom
          Positioned(
            left: 20,
            bottom: 20,
            right: 20,
            child: _TermsAndPolicyLinks(
                textColor: white), // White text on purple background
          ),
        ],
      ),
    );
  }
}

// Widget for the Terms & Privacy Policy links
class _TermsAndPolicyLinks extends StatelessWidget {
  final Color textColor;
  const _TermsAndPolicyLinks({this.textColor = primary});

  @override
  Widget build(BuildContext context) {
    // Use a Theme to apply the text color override for the links
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 12,
        color: textColor,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('terms & conditions'),
          SizedBox(width: 8),
          Text('|'),
          SizedBox(width: 8),
          Text('privacy policy'),
        ],
      ),
    );
  }
}

// Main function to run the app
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Webmail Login UI',
//       home: WebmailLoginScreen(),
//     );
//   }
// }