// lib/utils/marker_clustering.dart
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/models/cat_spot.dart';
import 'package:flutter/material.dart';

class ClusterItem {
  final LatLng position;
  final CatSpot spot;

  ClusterItem(this.position, this.spot);
}

class Cluster {
  final LatLng center;
  final List<ClusterItem> items;
  
  Cluster(this.center, this.items);
  
  int get size => items.length;
}

class MarkerClusterer {
  static const double CLUSTER_RADIUS = 80.0;
  
  static List<Cluster> createClusters(
    List<ClusterItem> items,
    double zoom,
    Size mapSize,
    LatLngBounds bounds,
  ) {
    List<Cluster> clusters = [];
    List<ClusterItem> unclustered = List.from(items);
    
    while (unclustered.isNotEmpty) {
      ClusterItem item = unclustered.first;
      List<ClusterItem> clusterItems = [];
      
      for (var i = unclustered.length - 1; i >= 0; i--) {
        var other = unclustered[i];
        if (_shouldCluster(item.position, other.position, zoom, mapSize, bounds)) {
          clusterItems.add(other);
          unclustered.removeAt(i);
        }
      }
      
      if (clusterItems.isNotEmpty) {
        clusters.add(_createCluster(clusterItems));
      }
    }
    
    return clusters;
  }
  
  static bool _shouldCluster(
    LatLng p1,
    LatLng p2,
    double zoom,
    Size mapSize,
    LatLngBounds bounds,
  ) {
    var pixelDistance = _getPixelDistance(p1, p2, zoom, mapSize, bounds);
    return pixelDistance <= CLUSTER_RADIUS;
  }
  
  static double _getPixelDistance(
    LatLng p1,
    LatLng p2,
    double zoom,
    Size mapSize,
    LatLngBounds bounds,
  ) {
    var lat1 = _project(p1.latitude, bounds, mapSize.height);
    var lng1 = _project(p1.longitude, bounds, mapSize.width);
    var lat2 = _project(p2.latitude, bounds, mapSize.height);
    var lng2 = _project(p2.longitude, bounds, mapSize.width);
    
    return _distance(lat1, lng1, lat2, lng2);
  }
  
  static double _project(double value, LatLngBounds bounds, double size) {
    var range = bounds.northeast.latitude - bounds.southwest.latitude;
    return (value - bounds.southwest.latitude) * size / range;
  }
  
  static double _distance(double x1, double y1, double x2, double y2) {
    var dx = x2 - x1;
    var dy = y2 - y1;
    return sqrt(dx * dx + dy * dy);
  }
  
  static Cluster _createCluster(List<ClusterItem> items) {
    var lat = 0.0;
    var lng = 0.0;
    
    for (var item in items) {
      lat += item.position.latitude;
      lng += item.position.longitude;
    }
    
    return Cluster(
      LatLng(lat / items.length, lng / items.length),
      items,
    );
  }
}