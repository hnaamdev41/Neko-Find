import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/image_picker_widget.dart';
import '../../data/repositories/cat_repository.dart';
import '../../data/models/cat_post.dart';
import '../../data/services/location_service.dart';
import '../../data/services/storage_service.dart';

class CreateAdoptionPostScreenController extends GetxController {
  final locationService = LocationService();
  final storageService = StorageService();
}

class CreateAdoptionPostScreen extends StatefulWidget {
  const CreateAdoptionPostScreen({super.key});

  @override
  State<CreateAdoptionPostScreen> createState() => _CreateAdoptionPostScreenState();
}

class _CreateAdoptionPostScreenState extends State<CreateAdoptionPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ageController = TextEditingController();
  final _contactController = TextEditingController();
  final _images = <String>[].obs;
  final _isLoading = false.obs;
  final _repository = CatRepository();
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Adoption Post'),
      ),
      body: Obx(() {
        if (_isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImagePickerWidget(
                  images: _images,
                  onImagesSelected: (images) => _images.value = images,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter a descriptive title',
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Title is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Describe the cat',
                  ),
                  maxLines: 3,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Description is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Estimated Age',
                    hintText: 'e.g., 2 years, 6 months',
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Age is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Information',
                    hintText: 'Phone number or email',
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Contact info is required' : null,
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Create Post'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _submitForm() async {
  if (!_formKey.currentState!.validate()) return;
  
  _isLoading.value = true;
  try {
    final controller = Get.put(CreateAdoptionPostScreenController());
    final position = await controller.locationService.getCurrentLocation();
    
    List<String> imageUrls = [];
    for (String imagePath in _images) {
      final url = await controller.storageService.uploadImage(File(imagePath));
      imageUrls.add(url);
    }
    
    final post = CatPost(
      id: DateTime.now().toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      estimatedAge: _ageController.text,
      contactInfo: _contactController.text,
      latitude: position.latitude,
      longitude: position.longitude,
      imageUrls: imageUrls,
      createdAt: DateTime.now(),
    );

    await _repository.createCatPost(post);
    Get.back(result: true);
    Get.snackbar('Success', 'Post created successfully');
  } catch (e) {
    Get.snackbar('Error', 'Failed to create post: $e');
  } finally {
    _isLoading.value = false;
  }
}
}