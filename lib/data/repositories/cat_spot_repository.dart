// lib/data/repositories/cat_spot_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cat_spot.dart';

class CatSpotRepository {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _table = 'cat_spots';

  Future<List<CatSpot>> getCatSpots() async {
    try {
      final response = await _supabase
          .from(_table)
          .select()
          .order('created_at', ascending: false);
      
      return response
          .map((json) => CatSpot.fromJson(json))
          .toList()
          .cast<CatSpot>();
    } catch (e) {
      throw Exception('Failed to fetch cat spots: $e');
    }
  }

  Future<void> createCatSpot(CatSpot spot) async {
    try {
      await _supabase
          .from(_table)
          .insert(spot.toJson());
    } catch (e) {
      throw Exception('Failed to create cat spot: $e');
    }
  }

  Future<void> deleteCatSpot(String id) async {
    try {
      await _supabase
          .from(_table)
          .delete()
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete cat spot: $e');
    }
  }

  Stream<List<CatSpot>> getCatSpotsStream() {
    return _supabase
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((rows) => rows
            .map((row) => CatSpot.fromJson(row))
            .toList()
            .cast<CatSpot>());
  }
}