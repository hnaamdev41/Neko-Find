// lib/presentation/widgets/location_picker_widget.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerWidget extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  const LocationPickerWidget({super.key, required this.onLocationSelected});

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  LatLng? selectedLocation;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 15,
        ),
        markers: markers,
        onTap: (LatLng location) {
          setState(() {
            selectedLocation = location;
            markers = {
              Marker(
                markerId: const MarkerId('selected'),
                position: location,
              ),
            };
          });
          widget.onLocationSelected(location);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}