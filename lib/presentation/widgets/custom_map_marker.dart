// lib/presentation/widgets/custom_map_marker.dart
import 'package:flutter/material.dart';

class CustomMapMarker extends StatelessWidget {
  final bool isSelected;

  const CustomMapMarker({
    super.key,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.red,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.pets,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}