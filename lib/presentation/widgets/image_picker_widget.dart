import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatelessWidget {
  final List<String> images;
  final Function(List<String>) onImagesSelected;
  final int maxImages;

  const ImagePickerWidget({
    super.key,
    required this.images,
    required this.onImagesSelected,
    this.maxImages = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photos',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              if (images.length < maxImages)
                _AddImageButton(
                  onTap: () => _pickImage(context),
                ),
              ...images.map(
                (image) => _ImageThumbnail(
                  imageUrl: image,
                  onDelete: () {
                    final newImages = List<String>.from(images)
                      ..remove(image);
                    onImagesSelected(newImages);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      final newImages = List<String>.from(images)
        ..add(pickedFile.path);
      onImagesSelected(newImages);
    }
  }
}

class _AddImageButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddImageButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: const Icon(Icons.add_photo_alternate),
        onPressed: onTap,
      ),
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onDelete;

  const _ImageThumbnail({
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(imageUrl),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
