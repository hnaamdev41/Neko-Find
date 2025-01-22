// lib/data/repositories/user_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart' as app_user;

class UserRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<app_user.User?> getCurrentUser() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return null;

    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();
      return app_user.User.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> createOrUpdateUser(app_user.User user) async {
    await _supabase
        .from('users')
        .upsert(user.toJson(), onConflict: 'id');
  }

  Future<int> getUserSpotCount(String userId) async {
    final response = await _supabase
        .from('cat_spots')
        .select('id')
        .eq('user_id', userId);
    return response.length;
  }

  Future<void> updateUserProfile({
    required String userId,
    String? username,
    String? avatarUrl,
    bool? hasPets,
    int? petCount,
  }) async {
    final updates = {
      if (username != null) 'username': username,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (hasPets != null) 'hasPets': hasPets,
      if (petCount != null) 'petCount': petCount,
    };

    await _supabase
        .from('users')
        .update(updates)
        .eq('id', userId);
  }
}