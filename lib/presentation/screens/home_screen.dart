// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../../data/services/content_generator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feeds = CatContentGenerator.generateFeeds();

    return Scaffold(
      appBar: AppBar(title: const Text('Neko Find')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: feeds.length,
        itemBuilder: (context, index) {
          final feed = feeds[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.pets, size: 48),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          feed['type'],
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feed['title'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(feed['description']),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(feed['likes'].toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}