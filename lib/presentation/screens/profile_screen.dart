// lib/presentation/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/auth_service.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.find<AuthService>().signOut(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Cat-themed profile header
              Stack(
                alignment: Alignment.center,
                children: [
                  // Cat ears background
                  CustomPaint(
                    size: const Size(double.infinity, 200),
                    painter: CatEarsPainter(theme.colorScheme.primary),
                  ),
                  // Profile picture
                  Column(
                    children: [
                      GestureDetector(
                        onTap: controller.updateProfilePicture,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: theme.colorScheme.secondary,
                              backgroundImage: controller.user.value?.avatarUrl != null
                                  ? NetworkImage(controller.user.value!.avatarUrl!)
                                  : null,
                              child: controller.user.value?.avatarUrl == null
                                  ? const Icon(Icons.person, size: 60)
                                  : null,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: theme.colorScheme.primary,
                                radius: 18,
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.user.value?.username ?? 'Neko User',
                        style: theme.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Profile stats in cat paw layout
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PawStatCard(
                    icon: Icons.pets,
                    label: 'Cat Spots',
                    value: '${controller.spotCount}',
                  ),
                  const SizedBox(width: 16),
                  _PawStatCard(
                    icon: Icons.favorite,
                    label: 'Favorites',
                    value: '${controller.user.value?.favoritePosts.length ?? 0}',
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Profile form
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: controller.user.value?.username,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: controller.updateUsername,
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Do you have pets?'),
                        value: controller.user.value?.hasPets ?? false,
                        onChanged: controller.updateHasPets,
                      ),
                      if (controller.user.value?.hasPets ?? false) ...[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Text('Number of pets:'),
                            const SizedBox(width: 16),
                            DropdownButton<int>(
                              value: controller.user.value?.petCount ?? 0,
                              items: List.generate(10, (i) => i + 1)
                                  .map((count) => DropdownMenuItem(
                                        value: count,
                                        child: Text('$count'),
                                      ))
                                  .toList(),
                              onChanged: controller.updatePetCount,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CatEarsPainter extends CustomPainter {
  final Color color;

  CatEarsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.3, 0)
      ..lineTo(size.width * 0.5, size.height * 0.3)
      ..lineTo(size.width * 0.7, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PawStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _PawStatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(label),
        ],
      ),
    );
  }
}