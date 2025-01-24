// lib/presentation/controllers/map_controller.dart
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/location_service.dart';
import '../../data/services/storage_service.dart';
import '../../data/services/auth_service.dart';
import '../../data/repositories/cat_spot_repository.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../data/models/cat_spot.dart';
import '../../utils/marker_clustering.dart';
import '../../utils/marker_clustering.dart' as marker_cluster;
import 'package:neko_find/utils/marker_clustering.dart' hide Cluster;

class MapController extends GetxController {
 final _locationService = LocationService();
 final _storageService = StorageService();
 final _catSpotRepository = CatSpotRepository();
 final _favoritesRepository = FavoritesRepository();
 final _authService = Get.find<AuthService>();

 final currentLocation = Rx<LatLng>(const LatLng(0, 0));
 final markers = <Marker>{}.obs;
 final isLoading = true.obs;
 final isDialogOpen = false.obs;
 final clusters = <marker_cluster.Cluster>[].obs;
 final mapSize = const Size(0, 0).obs;
 final spots = <CatSpot>[].obs;
 final favoriteSpots = <String>[].obs;

 BitmapDescriptor? customMarkerIcon;
 GoogleMapController? mapController;

 String get mapStyleString => '''[
   {
     "elementType": "geometry",
     "stylers": [{"color": "#212121"}]
   },
   {
     "elementType": "labels",
     "stylers": [{"visibility": "off"}]
   },
   {
     "featureType": "administrative",
     "stylers": [{"visibility": "off"}]
   },
   {
     "featureType": "poi",
     "stylers": [{"visibility": "off"}]
   },
   {
     "featureType": "road",
     "elementType": "geometry",
     "stylers": [{"color": "#424242"}]
   },
   {
     "featureType": "road",
     "elementType": "geometry.stroke",
     "stylers": [{"color": "#212121"}]
   },
   {
     "featureType": "transit",
     "stylers": [{"visibility": "off"}]
   },
   {
     "featureType": "water",
     "elementType": "geometry",
     "stylers": [{"color": "#000000"}]
   }
 ]''';

 @override
 void onInit() {
   super.onInit();
   _initializeMap();
   _loadCustomMarker();
   _loadSavedData(); 
   ever(spots, (_) => _saveData());
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

Future<void> _loadCustomMarker() async {
  try {
    final ByteData data = await rootBundle.load('assets/icons/paw-icon.svg');
    final String svgString = String.fromCharCodes(data.buffer.asUint8List());
    
    // Create a PictureRecorder and Canvas
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    
    // Draw a circle with paw icon
    final paint = Paint()
      ..color = Get.theme.primaryColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(const Offset(48, 48), 48, paint);
    
    // Draw paw icon
    final icon = Icons.pets;
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 48,
          fontFamily: icon.fontFamily,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(48 - textPainter.width / 2, 48 - textPainter.height / 2),
    );

    // Convert to image
    final ui.Image image = await recorder.endRecording().toImage(96, 96);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      customMarkerIcon = BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
    }
  } catch (e) {
    debugPrint('Error loading custom marker: $e');
    customMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }
}

Future<void> loadCatSpots() async {
  try {
    final newSpots = await _catSpotRepository.getCatSpots();
    // Merge with existing spots, avoiding duplicates
    final existingIds = spots.map((s) => s.id).toSet();
    spots.value = [
      ...spots,
      ...newSpots.where((s) => !existingIds.contains(s.id))
    ];
    updateClusters();
  } catch (e) {
    Get.snackbar('Error', 'Failed to load cat spots: $e');
  }
}

 Future<void> _loadSavedData() async {
   try {
     await loadCatSpots();
     final prefs = await SharedPreferences.getInstance();
     final savedSpots = prefs.getStringList('cat_spots');
     if (savedSpots != null) {
       spots.value = savedSpots
           .map((json) => CatSpot.fromJson(jsonDecode(json)))
           .toList();
       updateClusters();
     }
   } catch (e) {
     debugPrint('Error loading saved data: $e');
   }
 }

 Future<void> _saveData() async {
   try {
     final prefs = await SharedPreferences.getInstance();
     final spotsJson = spots
         .map((spot) => jsonEncode(spot.toJson()))
         .toList();
     await prefs.setStringList('cat_spots', spotsJson);
   } catch (e) {
     debugPrint('Error saving data: $e');
   }
 }

 Future<void> _loadFavorites() async {
   if (_authService.currentUser.value?.id != null) {
     favoriteSpots.value = await _favoritesRepository.getFavoriteSpots(
       _authService.currentUser.value!.id
     );
   }
 }

 Future<void> toggleFavorite(String spotId) async {
   if (_authService.currentUser.value?.id == null) {
     Get.toNamed('/login');
     return;
   }

   try {
     await _favoritesRepository.toggleFavorite(
       _authService.currentUser.value!.id,
       spotId,
     );
     await _loadFavorites();
     Get.snackbar(
       'Success', 
       favoriteSpots.contains(spotId) 
         ? 'Added to favorites'
         : 'Removed from favorites'
     );
   } catch (e) {
     Get.snackbar('Error', 'Failed to update favorite: $e');
   }
 }

 Future<void> updateClusters() async {
   if (mapController == null) return;
   
   final bounds = await mapController!.getVisibleRegion();
   final zoom = await mapController!.getZoomLevel();
   
   final items = spots.map((spot) => ClusterItem(
     LatLng(spot.latitude, spot.longitude),
     spot,
   )).toList();
   
   clusters.value = MarkerClusterer.createClusters(
     items,
     zoom,
     mapSize.value,
     bounds,
   );
   
   await _updateMarkers();
 }

 Future<void> _updateMarkers() async {
   markers.clear();
   
   for (var cluster in clusters) {
     if (cluster.size == 1) {
       final spot = cluster.items.first.spot;
       markers.add(await _createSpotMarker(spot));
     } else {
       markers.add(
         Marker(
           markerId: MarkerId('cluster_${cluster.center}'),
           position: cluster.center,
           icon: await _getClusterIcon(cluster.size),
           onTap: () => _showClusterDetails(cluster),
         ),
       );
     }
   }
 }

 Future<Marker> _createSpotMarker(CatSpot spot) async {
   return Marker(
     markerId: MarkerId(spot.id),
     position: LatLng(spot.latitude, spot.longitude),
     icon: customMarkerIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
     onTap: () => _showSpotDetails(spot),
   );
 }

Future<BitmapDescriptor> _getClusterIcon(int size) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()..color = Get.theme.colorScheme.primary;
  
  // Size categories
  final double radius = _getClusterRadius(size);
  canvas.drawCircle(Offset(radius, radius), radius, paint);
  
  // Add inner circle for larger clusters
  if (size > 10) {
    final innerPaint = Paint()..color = Colors.white.withOpacity(0.3);
    canvas.drawCircle(Offset(radius, radius), radius * 0.7, innerPaint);
  }
  
  TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: _formatClusterSize(size),
      style: TextStyle(
        color: Colors.white,
        fontSize: size > 99 ? 24 : 32,
        fontWeight: FontWeight.bold,
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset(radius - textPainter.width / 2, radius - textPainter.height / 2),
  );
  
  final image = await recorder.endRecording().toImage(radius.toInt() * 2, radius.toInt() * 2);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}

double _getClusterRadius(int size) {
  if (size < 10) return 40;
  if (size < 50) return 50;
  if (size < 100) return 60;
  return 70;
}

String _formatClusterSize(int size) {
  if (size < 100) return size.toString();
  if (size < 1000) return '${(size / 100).floor()}00+';
  return '999+';
}

 void _showClusterDetails(marker_cluster.Cluster cluster) {
   Get.bottomSheet(
     Container(
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: Get.theme.scaffoldBackgroundColor,
         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
       ),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Text(
             '${cluster.size} Cats in this area',
             style: Get.textTheme.titleLarge,
           ),
           const SizedBox(height: 16),
           Expanded(
             child: ListView.builder(
               itemCount: cluster.items.length,
               itemBuilder: (context, index) {
                 final spot = cluster.items[index].spot;
                 return ListTile(
                   leading: spot.imageUrls.isNotEmpty
                     ? CircleAvatar(
                         backgroundImage: NetworkImage(spot.imageUrls.first),
                       )
                     : const CircleAvatar(child: Icon(Icons.pets)),
                   title: Text(spot.name),
                   subtitle: Text('${spot.catCount} cats'),
                   trailing: IconButton(
                     icon: Icon(
                       favoriteSpots.contains(spot.id)
                         ? Icons.favorite
                         : Icons.favorite_border,
                     ),
                     onPressed: () => toggleFavorite(spot.id),
                   ),
                   onTap: () {
                     Get.back();
                     _showSpotDetails(spot);
                   },
                 );
               },
             ),
           ),
         ],
       ),
     ),
     isScrollControlled: true,
   );
 }

 void _showSpotDetails(CatSpot spot) {
   Get.bottomSheet(
     Container(
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: Get.theme.scaffoldBackgroundColor,
         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
       ),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           if (spot.imageUrls.isNotEmpty)
             SizedBox(
               height: 200,
               child: PageView.builder(
                 itemCount: spot.imageUrls.length,
                 itemBuilder: (context, index) => Image.network(
                   spot.imageUrls[index],
                   fit: BoxFit.cover,
                 ),
               ),
             ),
           const SizedBox(height: 16),
           Text(spot.name, style: Get.textTheme.headlineSmall),
           Text('${spot.catCount} cats near ${spot.nearbyLocation}'),
           if (spot.username != null)
             Text('Added by: ${spot.username}'),
           const SizedBox(height: 16),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               IconButton(
                 icon: const Icon(Icons.share),
                 onPressed: () => _shareSpot(spot),
               ),
               IconButton(
                 icon: Icon(
                   favoriteSpots.contains(spot.id)
                     ? Icons.favorite
                     : Icons.favorite_border,
                 ),
                 onPressed: () => toggleFavorite(spot.id),
               ),
             ],
           ),
         ],
       ),
     ),
     isScrollControlled: true,
   );
 }

 void _shareSpot(CatSpot spot) {
   Share.share(
     'Check out this cat spot at ${spot.name}!\nFound ${spot.catCount} cats near ${spot.nearbyLocation}',
     subject: 'Cat Spot at ${spot.name}',
   );
 }

 Future<void> updateMapStyle() async {
   if (mapController != null) {
     await mapController!.setMapStyle(mapStyleString);
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

 Future<void> addCatSpot(Map<String, dynamic> spotData) async {
   try {
     final position = await _locationService.getCurrentLocation();
     final location = LatLng(position.latitude, position.longitude);
     
     List<String> imageUrls = [];
     if (spotData['images'] != null) {
       for (String imagePath in spotData['images']) {
         final file = File(imagePath);
         final url = await _storageService.uploadImage(file);
         imageUrls.add(url);
       }
     }

     final spot = CatSpot(
       id: DateTime.now().millisecondsSinceEpoch.toString(),
       name: spotData['locationName'],
       catCount: spotData['catCount'],
       nearbyLocation: spotData['nearbyLocation'],
       latitude: location.latitude,
       longitude: location.longitude,
       imageUrls: imageUrls,
       userId: spotData['userId'],
       username: spotData['username'],
     );

     await _catSpotRepository.createCatSpot(spot);
     await loadCatSpots();

     Get.back();
     Get.snackbar('Success', 'Cat spot added successfully');
   } catch (e) {
     Get.snackbar('Error', 'Failed to add spot: $e');
   }
 }

 void showFavoriteSpots() {
   if (_authService.currentUser.value == null) {
     Get.toNamed('/login');
     return;
   }

   final favoriteSpotsList = spots.where(
     (spot) => favoriteSpots.contains(spot.id)
     ).toList();

   if (favoriteSpotsList.isEmpty) {
     Get.snackbar('Info', 'No favorite spots yet');
     return;
   }

   Get.bottomSheet(
     Container(
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: Get.theme.scaffoldBackgroundColor,
         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
       ),
       child: Column(
         children: [
           Text(
             'Favorite Spots',
             style: Get.textTheme.titleLarge,
           ),
           const SizedBox(height: 16),
           Expanded(
             child: ListView.builder(
               itemCount: favoriteSpotsList.length,
               itemBuilder: (context, index) {
                 final spot = favoriteSpotsList[index];
                 return ListTile(
                   leading: spot.imageUrls.isNotEmpty
                     ? CircleAvatar(
                         backgroundImage: NetworkImage(spot.imageUrls.first),
                       )
                     : const CircleAvatar(child: Icon(Icons.pets)),
                   title: Text(spot.name),
                   subtitle: Text('${spot.catCount} cats'),
                   onTap: () {
                     Get.back();
                     mapController?.animateCamera(
                       CameraUpdate.newLatLngZoom(
                         LatLng(spot.latitude, spot.longitude),
                         18,
                       ),
                     );
                     _showSpotDetails(spot);
                   },
                 );
               },
             ),
           ),
         ],
       ),
     ),
     isScrollControlled: true,
   );
 }

 @override
 void onClose() {
   _saveData();
   mapController?.dispose();
   super.onClose();
 }
}