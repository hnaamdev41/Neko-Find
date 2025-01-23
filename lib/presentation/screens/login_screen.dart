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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                _buildCatLogo(),
                const SizedBox(height: 40),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Obx(() => AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          crossFadeState: isSignUp.value 
                            ? CrossFadeState.showSecond 
                            : CrossFadeState.showFirst,
                          firstChild: const Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          secondChild: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                        const SizedBox(height: 24),
                        Obx(() => Column(
                          children: [
                            if (isSignUp.value)
                              _buildTextField(
                                controller: usernameController,
                                icon: Icons.person,
                                label: 'Username',
                              ),
                            _buildTextField(
                              controller: emailController,
                              icon: Icons.email,
                              label: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            _buildTextField(
                              controller: passwordController,
                              icon: Icons.lock,
                              label: 'Password',
                              isPassword: true,
                            ),
                          ],
                        )),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Obx(() => ElevatedButton(
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
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                isSignUp.value ? 'Sign Up' : 'Sign In',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          )),
                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCatLogo() {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Image.asset('assets/images/cat_logo.png'),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}