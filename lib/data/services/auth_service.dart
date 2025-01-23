// lib/data/services/auth_service.dart
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart' as app_user;
import '../repositories/user_repository.dart';

class AuthService extends GetxService {
  final _supabase = Supabase.instance.client;
  final _userRepository = UserRepository();
  final currentUser = Rx<app_user.User?>(null);
  final isLoading = false.obs;

  Future<AuthService> init() async {
    _supabase.auth.onAuthStateChange.listen((event) async {
      if (event.event == AuthChangeEvent.signedIn) {
        currentUser.value = await _userRepository.getCurrentUser();
      } else if (event.event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
      }
    });
    
    if (_supabase.auth.currentUser != null) {
      currentUser.value = await _userRepository.getCurrentUser();
    }
    
    return this;
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
      Get.snackbar('Error', 'Failed to sign in: $e');
    } finally {
      isLoading.value = false;
    }
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
        createdAt: DateTime.now(),
      );
      
      await _userRepository.createOrUpdateUser(newUser);
      currentUser.value = newUser;
      Get.offAllNamed('/main');
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to sign up: $e');
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
      Get.snackbar('Error', 'Failed to sign out: $e');
    }
  }
}