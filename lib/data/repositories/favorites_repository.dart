// lib/data/repositories/favorites_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesRepository {
  final _supabase = Supabase.instance.client;
  final _table = 'favorite_spots';

  Future<void> toggleFavorite(String userId, String spotId) async {
    try {
      final exists = await _supabase
          .from(_table)
          .select()
          .eq('user_id', userId)
          .eq('spot_id', spotId)
          .maybeSingle();

      if (exists == null) {
        await _supabase.from(_table).insert({
          'user_id': userId,
          'spot_id': spotId,
          'created_at': DateTime.now().toIso8601String(),
        });
      } else {
        await _supabase
          .from(_table)
          .delete()
          .eq('user_id', userId)
          .eq('spot_id', spotId);
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  Future<List<String>> getFavoriteSpots(String userId) async {
    try {
      final response = await _supabase
          .from(_table)
          .select('spot_id')
          .eq('user_id', userId);
      
      return response.map((r) => r['spot_id'] as String).toList();
    } catch (e) {
      throw Exception('Failed to get favorite spots: $e');
    }
  }
}