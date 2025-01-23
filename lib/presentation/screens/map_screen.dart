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
     body: Stack(
       children: [
         Obx(() => controller.isLoading.value
           ? const Center(child: CircularProgressIndicator())
           : LayoutBuilder(
               builder: (context, constraints) {
                 controller.mapSize.value = Size(
                   constraints.maxWidth,
                   constraints.maxHeight
                 );
                 
                 return GoogleMap(
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
                   buildingsEnabled: true,
                   compassEnabled: true,
                   trafficEnabled: false,
                   padding: const EdgeInsets.only(bottom: 100),
                   onMapCreated: (GoogleMapController mapController) async {
                     controller.mapController = mapController;
                     await controller.updateMapStyle();
                   },
                   onCameraMove: (CameraPosition position) {
                     controller.updateCurrentLocation(position.target);
                     controller.updateClusters();
                   },
                   onCameraIdle: () => controller.updateClusters(),
                 );
               },
             ),
         ),
         
         // Top Bar Shadow
         Positioned(
           top: 0,
           left: 0,
           right: 0,
           child: Container(
             height: 50,
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [
                   Colors.black.withOpacity(0.3),
                   Colors.transparent,
                 ],
               ),
             ),
           ),
         ),
         
         // Controls overlay
         Positioned(
           right: 16,
           bottom: 100,
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               _buildFabButton(
                 heroTag: 'locate_me',
                 icon: Icons.my_location,
                 onPressed: () => controller.centerOnCurrentLocation(),
                 theme: theme,
               ),
               const SizedBox(height: 8),
               _buildFabButton(
                 heroTag: 'refresh_spots',
                 icon: Icons.refresh,
                 onPressed: () => controller.loadCatSpots(),
                 theme: theme,
               ),
               const SizedBox(height: 8),
               _buildFabButton(
                 heroTag: 'favorites',
                 icon: Icons.favorite,
                 onPressed: () => controller.showFavoriteSpots(),
                 theme: theme,
               ),
             ],
           ),
         ),
       ],
     ),
     floatingActionButton: Obx(() => controller.isDialogOpen.value 
       ? const SizedBox() 
       : FloatingActionButton.extended(
           heroTag: 'map_fab',
           onPressed: () async {
             controller.isDialogOpen.value = true;
             final result = await Get.dialog(
               const AddSpotDialog(),
               barrierDismissible: false,
             );
             if (result != null) {
               await controller.addCatSpot(result);
             }
             controller.isDialogOpen.value = false;
           },
           backgroundColor: theme.colorScheme.primary,
           foregroundColor: Colors.white,
           elevation: 4,
           icon: const Icon(Icons.add_location),
           label: const Text('Add Cat Spot'),
         ),
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
   );
 }

 Widget _buildFabButton({
   required String heroTag,
   required IconData icon,
   required VoidCallback onPressed,
   required ThemeData theme,
 }) {
   return Container(
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(16),
       boxShadow: [
         BoxShadow(
           color: Colors.black.withOpacity(0.2),
           blurRadius: 6,
           offset: const Offset(0, 2),
         ),
       ],
     ),
     child: FloatingActionButton.small(
       heroTag: heroTag,
       onPressed: onPressed,
       backgroundColor: theme.colorScheme.primary,
       foregroundColor: Colors.white,
       elevation: 0,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(16),
       ),
       child: Icon(icon),
     ),
   );
 }
}