// lib/presentation/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/map_controller.dart';
import '../widgets/add_spot_dialog.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Map'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.currentLocation.value,
                  zoom: 15.0,
                ),
                markers: controller.markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController mapController) {
                  controller.mapController = mapController;
                  controller.updateMapStyle();
                },
                onCameraMove: (CameraPosition position) {
                  controller.updateCurrentLocation(position.target);
                },
                style: controller.mapStyleString,
              ),
          ),
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.small(
                  heroTag: 'locate_me',
                  onPressed: () => controller.centerOnCurrentLocation(),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.my_location),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.small(
                  heroTag: 'refresh_spots',
                  onPressed: () => controller.loadCatSpots(),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'map_fab',
        onPressed: () async {
          controller.isDialogOpen.value = true;
          final result = await Get.dialog(const AddSpotDialog());
          if (result != null) {
            await controller.addCatSpot(result);
          }
          controller.isDialogOpen.value = false;
        },
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_location),
        label: const Text('Add Cat Spot'),
      ),
    );
  }
}