// lib/presentation/widgets/add_spot_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/auth_service.dart';
import 'dart:io';

class AddSpotDialog extends StatefulWidget {
  const AddSpotDialog({super.key});

  @override
  State<AddSpotDialog> createState() => _AddSpotDialogState();
}

class _AddSpotDialogState extends State<AddSpotDialog> {
  final locationNameController = TextEditingController();
  final catCountController = TextEditingController();
  final nearbyLocationController = TextEditingController();
  final images = <String>[].obs;
  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Cat Spot'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: images.length + 1,
                itemBuilder: (context, index) {
                  if (index == images.length) {
                    return InkWell(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add_photo_alternate),
                      ),
                    );
                  }
                  return Stack(
                    children: [
                      Image.file(File(images[index]), fit: BoxFit.cover),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => setState(() => images.removeAt(index)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationNameController,
              decoration: const InputDecoration(
                labelText: 'Location Name',
                hintText: 'e.g., Central Park'
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: catCountController,
              decoration: const InputDecoration(
                labelText: 'Number of Cats',
                hintText: 'e.g., 3'
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nearbyLocationController,
              decoration: const InputDecoration(
                labelText: 'Nearby Location',
                hintText: 'e.g., Near coffee shop'
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_validateInput()) return;
            
            Get.back(result: {
              'locationName': locationNameController.text,
              'catCount': catCountController.text,
              'nearbyLocation': nearbyLocationController.text,
              'images': images,
              'userId': authService.currentUser.value?.id,
              'username': authService.currentUser.value?.username,
            });
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() => images.add(pickedFile.path));
    }
  }

  bool _validateInput() {
    if (locationNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a location name');
      return false;
    }
    if (catCountController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter number of cats');
      return false;
    }
    return true;
  }
}