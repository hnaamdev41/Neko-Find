// lib/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final usernameController = TextEditingController();
    final isSignUp = false.obs;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/cat_logo.png', height: 120),
              const SizedBox(height: 32),
              Obx(() => isSignUp.value
                ? TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  )
                : const SizedBox()),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              Obx(() => ElevatedButton(
                onPressed: () => isSignUp.value
                  ? authService.signUp(
                      emailController.text,
                      passwordController.text,
                      usernameController.text,
                    )
                  : authService.signIn(
                      emailController.text,
                      passwordController.text,
                    ),
                child: Text(isSignUp.value ? 'Sign Up' : 'Sign In'),
              )),
              TextButton(
                onPressed: () => isSignUp.toggle(),
                child: Obx(() => Text(
                  isSignUp.value
                    ? 'Already have an account? Sign In'
                    : 'Need an account? Sign Up',
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}