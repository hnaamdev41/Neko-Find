// lib/data/repositories/cat_spot_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cat_spot.dart';

class CatSpotRepository {
  final _supabase = Supabase.instance.client;
  final _table = 'cat_spots';

Future<List<CatSpot>> getCatSpots() async {
  try {
    final response = await _supabase
        .from(_table)
        .select()
        .order('created_at', ascending: false);
    
    return response.map((json) => CatSpot.fromJson(json)).toList();
  } catch (e) {
    throw Exception('Failed to fetch cat spots: $e');
  }
}


  Future<void> createCatSpot(CatSpot spot) async {
    try {
      // Remove username from the JSON as it's not a direct column
      final json = spot.toJson();
      json.remove('username');  // Remove username before insert
      
      await _supabase
          .from(_table)
          .insert(json);
    } catch (e) {
      throw Exception('Failed to create cat spot: $e');
    }
  }
}