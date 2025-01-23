// lib/presentation/widgets/adoption_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/cat_post.dart';
import '../../core/theme/app_theme.dart';

class AdoptionCard extends StatelessWidget {
  final CatPost cat;
  final VoidCallback onTap;

  const AdoptionCard({
    super.key,
    required this.cat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 1,
                child: _buildImage(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cat.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Age: ${cat.estimatedAge}',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary.withOpacity(0.8),
                      ),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: onTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Meet Me!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (cat.imageUrls.isEmpty) {
      return Container(
        color: AppColors.catGray.withOpacity(0.1),
        child: const Icon(
          Icons.pets,
          size: 48,
          color: AppColors.primary,
        ),
      );
    }

    return Hero(
      tag: 'cat_image_${cat.id}',
      child: CachedNetworkImage(
        imageUrl: cat.imageUrls.first,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppColors.catGray.withOpacity(0.1),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.catGray.withOpacity(0.1),
          child: const Icon(
            Icons.pets,
            size: 48,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}