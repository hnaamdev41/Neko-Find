// lib/presentation/controllers/map_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;
import '../../data/services/location_service.dart';
import '../../data/services/storage_service.dart';
import '../../data/repositories/cat_spot_repository.dart';
import '../../data/models/cat_spot.dart';
import 'dart:convert';

class MapController extends GetxController {
  final _locationService = LocationService();
  final _storageService = StorageService();
  final _catSpotRepository = CatSpotRepository();
  final currentLocation = Rx<LatLng>(const LatLng(0, 0));
  final markers = <Marker>{}.obs;
  final isLoading = true.obs;
  final isDialogOpen = false.obs;
  BitmapDescriptor? customMarkerIcon;
  GoogleMapController? mapController;

  String get mapStyleString => jsonEncode([
    {
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#212121"
        }
      ]
    },
    {
      "elementType": "labels.icon",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#212121"
        }
      ]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#757575"
        },
        {
          "visibility": "off"
        }
      ]
    },
    {
      "featureType": "administrative.country",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    },
    {
      "featureType": "administrative.locality",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#bdbdbd"
        }
      ]
    },
    {
      "featureType": "poi",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#2c2c2c"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels.icon",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#8a8a8a"
        }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#373737"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#3c3c3c"
        }
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#4e4e4e"
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "featureType": "transit",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#000000"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#3d3d3d"
        }
      ]
    }
  ]);

  @override
  void onInit() {
    super.onInit();
    _initializeMap();
    _loadCustomMarker();
    loadCatSpots();
  }

Future<void> _loadCustomMarker() async {
  try {
    final ByteData data = await rootBundle.load('assets/icons/paw-icon.svg');
    final String svgString = String.fromCharCodes(data.buffer.asUint8List());
    
    final PictureInfo pictureInfo = await vg.loadPicture(
      SvgStringLoader(svgString),
      null,
    );

    final ui.Image image = await pictureInfo.picture.toImage(48, 48);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      final Uint8List uint8List = byteData.buffer.asUint8List();
      customMarkerIcon = BitmapDescriptor.bytes(uint8List);
    }
  } catch (e) {
    debugPrint('Error loading custom marker: $e');
    customMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }
}

// Add this method to handle map style updates:
  Future<void> updateMapStyle() async {
    if (mapController != null) {
      await mapController!.setMapStyle(mapStyleString);
    }
  }

  Future<void> _initializeMap() async {
    try {
      final position = await _locationService.getCurrentLocation();
      currentLocation.value = LatLng(position.latitude, position.longitude);
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> centerOnCurrentLocation() async {
    try {
      final position = await _locationService.getCurrentLocation();
      final location = LatLng(position.latitude, position.longitude);
      currentLocation.value = location;
      mapController?.animateCamera(CameraUpdate.newLatLng(location));
    } catch (e) {
      Get.snackbar('Error', 'Failed to get current location');
    }
  }

  void updateCurrentLocation(LatLng location) {
    currentLocation.value = location;
  }

  Future<void> loadCatSpots() async {
    try {
      final spots = await _catSpotRepository.getCatSpots();
      markers.clear();
      
      for (final spot in spots) {
        final marker = Marker(
          markerId: MarkerId(spot.id),
          position: LatLng(spot.latitude, spot.longitude),
          icon: customMarkerIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () => _showSpotDetails(
            spot.name,
            spot.catCount,
            spot.nearbyLocation,
            spot.imageUrl,
            LatLng(spot.latitude, spot.longitude),
          ),
        );
        markers.add(marker);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cat spots: $e');
    }
  }

Future<void> addCatSpot(Map<String, dynamic> spotData) async {
  try {
    // Get the current location
    final position = await _locationService.getCurrentLocation();
    final location = LatLng(position.latitude, position.longitude);
    
    String? imageUrl;
    if (spotData['images'] != null && (spotData['images'] as List).isNotEmpty) {
      imageUrl = await _storageService.uploadImage(File(spotData['images'][0]));
    }

    final spot = CatSpot(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: spotData['locationName'],
      catCount: spotData['catCount'],
      nearbyLocation: spotData['nearbyLocation'],
      latitude: location.latitude,  // Use actual location instead of camera position
      longitude: location.longitude,
      imageUrl: imageUrl,
    );

    // Save to database
    await _catSpotRepository.createCatSpot(spot);

    // Add marker
    final marker = Marker(
      markerId: MarkerId(spot.id),
      position: location,  // Use same location
      icon: customMarkerIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onTap: () => _showSpotDetails(
        spot.name,
        spot.catCount,
        spot.nearbyLocation,
        spot.imageUrl,
        location,
      ),
    );

    markers.add(marker);

    // Center the map on the new marker
    mapController?.animateCamera(
      CameraUpdate.newLatLng(location),
    );

    Get.back();
    Get.snackbar('Success', 'Cat spot added successfully');
  } catch (e) {
    Get.snackbar('Error', 'Failed to add spot: $e');
  }
}
  void _showSpotDetails(
    String name, 
    String count, 
    String nearby, 
    String? imageUrl,
    LatLng position,
  ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageUrl != null) 
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(128),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Get.back(),
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
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withAlpha(26),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.pets, size: 16, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(
                                '$count cats',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            nearby,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Get.snackbar('Navigation', 'Navigation feature coming soon');
                          },
                          icon: const Icon(Icons.directions),
                          label: const Text('Directions'),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Get.back();
                            mapController?.animateCamera(
                              CameraUpdate.newLatLngZoom(position, 18),
                            );
                          },
                          icon: const Icon(Icons.zoom_in),
                          label: const Text('Zoom In'),
                        ),
                      ],
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

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }
}