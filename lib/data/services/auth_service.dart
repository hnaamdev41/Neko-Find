// lib/data/services/auth_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart' as app_user;
import '../repositories/user_repository.dart';

class AuthService extends GetxService {
  final _supabase = Supabase.instance.client;
  final _userRepository = UserRepository();
  
  final Rx<app_user.User?> currentUser = Rx<app_user.User?>(null);
  final RxBool isLoading = false.obs;

  Future<AuthService> init() async {

    return this;

  }

  Future<void> signUp(String email, String password, String username) async {
    try {
      isLoading.value = true;
      
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username}
      );

      if (response.user != null) {
        final newUser = app_user.User(
          id: response.user!.id,
          email: email,
          username: username,
          hasPets: false,
          petCount: 0,
          favoritePosts: [],
          createdAt: DateTime.now(),
        );
        
        await _userRepository.createOrUpdateUser(newUser);
        currentUser.value = newUser;
        Get.offAllNamed('/main');
      }
   } catch (e) {
    print('Signup error: $e'); // Add this for debugging
    Get.snackbar('Error', 'Failed to sign up: $e');
  } finally {
    isLoading.value = false;
  }
}

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        currentUser.value = await _userRepository.getCurrentUser();
        Get.offAllNamed('/main');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign in: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      currentUser.value = null;
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}