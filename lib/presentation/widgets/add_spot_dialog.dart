import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Cat Spot'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: _pickImage,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: images.isEmpty
                    ? const Icon(Icons.add_photo_alternate)
                    : Image.file(File(images.first), fit: BoxFit.cover),
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
            if (locationNameController.text.isEmpty) {
              Get.snackbar('Error', 'Please enter a location name');
              return;
            }
            
            Get.back(result: {
              'locationName': locationNameController.text,
              'catCount': catCountController.text.isEmpty ? '1' : catCountController.text,
              'nearbyLocation': nearbyLocationController.text,
              'images': images,
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
      images.add(pickedFile.path);
      setState(() {});
    }
  }
}
