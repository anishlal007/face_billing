import 'package:flutter/material.dart';

import '../masters/home/home_page.dart';

// You can define a constant for the main purple color
const Color kPrimaryColor = Color(0xFF673AB7); // A representative purple

class WebmailLoginScreen extends StatelessWidget {
  const WebmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder checks the screen constraints (width)
    return Scaffold(
      backgroundColor: Colors.white,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
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
class _WebmailLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Welcome Text
          const Text(
            'Welcome To Webmail',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor, // Use the main purple color
            ),
          ),
          const SizedBox(height: 30),

          // Email Input Field
          TextFormField(
            initialValue: 'anish@multiaccess.io', // Pre-filled value
            decoration: const InputDecoration(
              hintText: 'Email',
              // Hides the default bottom line for a cleaner look as in the image
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor, width: 2),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),

          // Password Input Field
          TextFormField(
            initialValue: '••••••••••', // A dummy password placeholder
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility_off, color: Colors.grey),
                onPressed: () {
                  // TODO: Implement password visibility toggle
                },
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor, width: 2),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
          const SizedBox(height: 40),

          // Sign In Button
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const HomePage()),
  (Route<dynamic> route) => false, // remove all previous routes
);
              // TODO: Implement login logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor, // Background color
              foregroundColor: Colors.white, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
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
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Stack(
        children: [
          // Placeholder for the logo (JD logo in the image)
          Center(
            child: Text(
              'JD', // Placeholder for the actual logo/image
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          // Links at the bottom
          Positioned(
            left: 20,
            bottom: 20,
            right: 20,
            child: _TermsAndPolicyLinks(
                textColor: Colors.white), // White text on purple background
          ),
        ],
      ),
    );
  }
}

// Widget for the Terms & Privacy Policy links
class _TermsAndPolicyLinks extends StatelessWidget {
  final Color textColor;
  const _TermsAndPolicyLinks({this.textColor = kPrimaryColor});

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