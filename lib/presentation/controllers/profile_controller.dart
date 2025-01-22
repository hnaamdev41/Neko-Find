// lib/presentation/controllers/profile_controller.dart
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/user.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/storage_service.dart';
import '../../data/repositories/user_repository.dart';

class ProfileController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _userRepository = UserRepository();
  final _storageService = StorageService();
  
  final user = Rx<User?>(null);
  final isLoading = false.obs;
  final spotCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = _authService.currentUser.value;
    _loadSpotCount();
  }

  Future<void> _loadSpotCount() async {
    if (user.value?.id != null) {
      spotCount.value = await _userRepository.getUserSpotCount(user.value!.id);
    }
  }

  Future<void> updateProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      isLoading.value = true;
      try {
        final imageUrl = await _storageService.uploadImage(File(pickedFile.path));
        await _userRepository.updateUserProfile(
          userId: user.value!.id,
          avatarUrl: imageUrl,
        );
        user.value = user.value!.copyWith(avatarUrl: imageUrl);
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> updateUsername(String? newUsername) async {
    if (newUsername?.isNotEmpty ?? false) {
      await _userRepository.updateUserProfile(
        userId: user.value!.id,
        username: newUsername,
      );
      user.value = user.value!.copyWith(username: newUsername!);
    }
  }

  Future<void> updateHasPets(bool? value) async {
    if (value != null) {
      await _userRepository.updateUserProfile(
        userId: user.value!.id,
        hasPets: value,
        petCount: value ? 1 : 0,
      );
      user.value = user.value!.copyWith(
        hasPets: value,
        petCount: value ? 1 : 0,
      );
    }
  }

  Future<void> updatePetCount(int? count) async {
    if (count != null) {
      await _userRepository.updateUserProfile(
        userId: user.value!.id,
        petCount: count,
      );
      user.value = user.value!.copyWith(petCount: count);
    }
  }
}