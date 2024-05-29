import 'package:flutter/material.dart';
import 'package:my_app/service/authentication_service.dart';
// ignore: duplicate_import
import 'package:my_app/service/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:my_app/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context, listen: false);

    // ignore: no_leading_underscores_for_local_identifiers
    void _login() async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
        String? result = await authService.signInWithEmailAndPassword(email, password);

        if (result != null) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to sign in')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: emailController,
              labelText: 'Email', maxLines: 3,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              labelText: 'Password',
              obscureText: true, maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Don\'t have an account? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}
