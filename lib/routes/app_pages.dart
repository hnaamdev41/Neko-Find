// lib/routes/app_pages.dart
import 'package:get/get.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/main_screen.dart';
import '../presentation/screens/profile_screen.dart';
import '../middleware/auth_middleware.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: '/main',
      page: () => const MainScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfileScreen(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}