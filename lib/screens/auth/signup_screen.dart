import 'package:chat_app/controllers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_services/auth_gate.dart';
import 'auth_button.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildNameField(),
                  const SizedBox(height: 20),
                  _buildEmailField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                  const SizedBox(height: 30),
                  AuthButton(
                    text: 'Sign Up',
                    onPressed: _handleSignup,
                  ),
                  const SizedBox(height: 20),
                  _buildLoginPrompt(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => const Text('Sign Up', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold));

  Widget _buildNameField() => TextFormField(
    controller: _nameController,
    decoration: const InputDecoration(
      labelText: 'Full Name',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.person),
    ),
    validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
  );

  Widget _buildEmailField() => TextFormField(
    controller: _emailController,
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
    controller: _passwordController,
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

  Widget _buildLoginPrompt() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Already have an account?'),
      TextButton(
        onPressed: () => Get.offNamed('/login_screen'),
        child: const Text('Login'),
      ),
    ],
  );

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final name = _nameController.text;

      final authController = Get.find<AuthController>();
      authController.startLoading();

      await AuthGate().signUp(email, password, name, 'https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.webp');
//hardcode here
      authController.stopLoading();
    }
  }
}