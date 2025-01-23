// lib/presentation/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'adoption_screen.dart';
import '../widgets/profile_avatar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = 0.obs;

    final screens = [
      const HomeScreen(),
      const MapScreen(),
      const AdoptionScreen(),
    ];

    final titles = ['', 'Cat Map', 'Adopt a Cat'];

    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex.value]),
        centerTitle: true,
        actions: [
          if (currentIndex.value == 0) 
            ProfileAvatar(onTap: () => Get.toNamed('/profile')),
        ],
      ),
      body: IndexedStack(
        index: currentIndex.value,
        children: screens,
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