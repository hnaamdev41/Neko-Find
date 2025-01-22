import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/cat_post.dart';

class CatPostCard extends StatelessWidget {
  final CatPost post;

  const CatPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.imageUrls.isNotEmpty)
            CachedNetworkImage(
              imageUrl: post.imageUrls.first,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(post.description),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(post.createdAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
