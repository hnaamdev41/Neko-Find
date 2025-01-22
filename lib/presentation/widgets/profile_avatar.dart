// lib/presentation/widgets/profile_avatar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/auth_service.dart';

class ProfileAvatar extends StatelessWidget {
  final VoidCallback onTap;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.onTap,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Obx(() {
          final user = authService.currentUser.value;
          return CircleAvatar(
            radius: size / 2,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            backgroundImage: user?.avatarUrl != null
                ? NetworkImage(user!.avatarUrl!)
                : null,
            child: user?.avatarUrl == null
                ? Icon(Icons.person, size: size / 2)
                : null,
          );
        }),
      ),
    );
  }
}