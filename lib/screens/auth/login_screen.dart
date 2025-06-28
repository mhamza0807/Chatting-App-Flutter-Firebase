import 'package:chat_app/utils/app_colors.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../services/auth_services/auth_gate.dart';
import 'auth_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  DateTime? _lastBackPressed;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 40),
                    _buildEmailField(),
                    const SizedBox(height: 20),
                    _buildPasswordField(),
                    const SizedBox(height: 10),
                    _buildForgotPassword(context),
                    const SizedBox(height: 30),
                    AuthButton(
                      text: 'Login',
                      onPressed: () => _handleLogin(context),
                    ),
                    const SizedBox(height: 20),
                    _buildSignupPrompt(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _handleWillPop() async {
    final now = DateTime.now();
    if (_lastBackPressed == null || now.difference(_lastBackPressed!) > Duration(seconds: 3)) {
      _lastBackPressed = now;
      Utils.toastMessage(message: 'Press back again to exit', color: AppColors.warn);
      return false;
    }
    return true;
  }

  Widget _buildHeader() => const Text('Login', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold));

  Widget _buildEmailField() => TextFormField(
    controller: emailController,
    decoration: const InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.email),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) return 'Please enter your email';
      final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegExp.hasMatch(value)) return 'Enter a valid email';
      return null;
    },

  );

  Widget _buildPasswordField() => TextFormField(
    controller: passwordController,
    decoration: const InputDecoration(
      labelText: 'Password',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.lock),
    ),
    obscureText: true,
    validator: (value) {
      if (value == null || value.isEmpty) return 'Please enter your password';
      if (value.length < 6) return 'Password must be at least 6 characters';
      return null;
    },
  );

  Widget _buildForgotPassword(BuildContext context) => Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Forgot password clicked')),
        );
      },
      child: const Text('Forgot Password?'),
    ),
  );

  Widget _buildSignupPrompt() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have an account?"),
      TextButton(
        onPressed: () => Get.toNamed('/signup_screen'),
        child: const Text('Sign Up'),
      ),
    ],
  );

  void _handleLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text;

      authController.startLoading();

      await AuthGate().login(email, password);

      authController.stopLoading();
    }
  }
}
