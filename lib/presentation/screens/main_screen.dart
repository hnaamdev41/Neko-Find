// lib/presentation/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/profile_avatar.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'adoption_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt currentIndex = 0.obs;

    return Obx(() => Scaffold(
      appBar: AppBar(
        title: const Text('Neko Find'),
        actions: [
          ProfileAvatar(
            onTap: () => Get.toNamed('/profile'),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex.value,
        children: const [
          HomeScreen(),
          MapScreen(),
          AdoptionScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex.value,
        onDestinationSelected: (index) => currentIndex.value = index,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.pets),
            label: 'Adopt',
          ),
        ],
      ),
    ));
  }
}