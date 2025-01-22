// lib/presentation/widgets/adoption_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/cat_post.dart';

class AdoptionCard extends StatelessWidget {
  final CatPost cat;
  final VoidCallback onTap;

  const AdoptionCard({
    super.key, 
    required this.cat, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with fixed height
            SizedBox(
              height: 120, // Fixed height for image
              width: double.infinity,
              child: cat.imageUrls.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: cat.imageUrls.first,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.pets, size: 50),
                    ),
                  )
                : Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.pets, size: 50),
                  ),
            ),
            // Content section with flexible height
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    cat.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Age: ${cat.estimatedAge}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Button section
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        minimumSize: const Size(double.infinity, 32),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}