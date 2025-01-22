// lib/presentation/screens/adoption_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/adoption_controller.dart';
import '../widgets/adoption_card.dart';
import 'create_adoption_post_screen.dart';
import '../../data/models/cat_post.dart';

class AdoptionScreen extends StatelessWidget {
  const AdoptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdoptionController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopt a Cat'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchAdoptableCats(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.adoptableCats.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.pets, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'No cats available for adoption yet',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => const CreateAdoptionPostScreen());
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add a Cat'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchAdoptableCats(),
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: controller.adoptableCats.length,
            itemBuilder: (context, index) {
              return AdoptionCard(
                cat: controller.adoptableCats[index],
                onTap: () => _showCatDetails(
                  context, 
                  controller.adoptableCats[index]
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        heroTag: 'adoption_fab',
        onPressed: () => Get.to(() => const CreateAdoptionPostScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCatDetails(BuildContext context, CatPost cat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  if (cat.imageUrls.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: cat.imageUrls.first,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black..withAlpha(128),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cat.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Age: ${cat.estimatedAge}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(cat.description),
                    const SizedBox(height: 24),
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Text('Latitude: ${cat.latitude.toStringAsFixed(6)}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Text('Longitude: ${cat.longitude.toStringAsFixed(6)}'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => _contactOwner(cat.contactInfo),
                      icon: const Icon(Icons.phone),
                      label: const Text('Contact'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _contactOwner(String contactInfo) {
    Get.snackbar(
      'Contact Info',
      contactInfo,
      duration: const Duration(seconds: 5),
    );
  }
}