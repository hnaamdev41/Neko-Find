import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../data/services/auth_service.dart';
import '../../core/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final usernameController = TextEditingController();
    final isSignUp = false.obs;
    final isPasswordVisible = false.obs;
    final isLoading = false.obs;

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
                const SizedBox(height: 40),
                _buildCatLogo(),
                const SizedBox(height: 20),
                Text(
                  'NekoFind',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Connect with cats around you',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 0.5,
                  ),
                ),
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
                          firstChild: Column(
                            children: [
                              const Text(
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Sign in to continue your paw-some adventure',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          secondChild: Column(
                            children: [
                              const Text(
                                'Join NekoFind',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Create an account to start helping cats',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: 24),
                        Obx(() => Column(
                          children: [
                            if (isSignUp.value)
                              _buildTextField(
                                controller: usernameController,
                                icon: Icons.person_outline,
                                label: 'Username',
                                hintText: 'Choose a username',
                              ),
                            _buildTextField(
                              controller: emailController,
                              icon: Icons.email_outlined,
                              label: 'Email',
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            Obx(() => TextField(
                              controller: passwordController,
                              obscureText: !isPasswordVisible.value,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () => isPasswordVisible.toggle(),
                                ),
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            )),
                          ],
                        )),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Obx(() => ElevatedButton(
                            onPressed: () {
                              isLoading.value = true;
                              if (isSignUp.value) {
                                authService.signUp(
                                  emailController.text,
                                  passwordController.text,
                                  usernameController.text,
                                ).then((_) => isLoading.value = false)
                                  .catchError((_) => isLoading.value = false);
                              } else {
                                authService.signIn(
                                  emailController.text,
                                  passwordController.text,
                                ).then((_) => isLoading.value = false)
                                  .catchError((_) => isLoading.value = false);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: isLoading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    isSignUp.value ? 'Create Account' : 'Sign In',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                            ),
                          )),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => isSignUp.toggle(),
                          child: Obx(() => Text(
                            isSignUp.value
                              ? 'Already have an account? Sign In'
                              : 'Need an account? Sign Up',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildPawPrints(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCatLogo() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow effect
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
        ),
        
        // Logo container
        Container(
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
            child: Image.asset(
              'assets/images/cat_logo.png',
              height: 80,
              width: 80,
            ),
          ),
        ),
        
        // Cat ears
        Positioned(
          top: 0,
          left: 30,
          child: _buildCatEar(isLeft: true),
        ),
        Positioned(
          top: 0,
          right: 30,
          child: _buildCatEar(isLeft: false),
        ),
      ],
    );
  }

  Widget _buildCatEar({required bool isLeft}) {
    return Transform.rotate(
      angle: isLeft ? -0.5 : 0.5,
      child: ClipPath(
        clipper: CatEarClipper(),
        child: Container(
          height: 30,
          width: 30,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hintText,
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
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildPawPrints() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Opacity(
            opacity: 0.6 - (index * 0.1),
            child: Transform.translate(
              offset: Offset(0, index.isEven ? -5 : 5),
              child: Icon(
                Icons.pets,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CatEarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}