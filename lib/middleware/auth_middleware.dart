// lib/middleware/auth_middleware.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    return authService.currentUser.value == null
        ? const RouteSettings(name: '/login')
        : null;
  }
}