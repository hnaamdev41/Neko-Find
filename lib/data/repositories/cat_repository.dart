// lib/data/repositories/cat_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cat_post.dart';

class CatRepository {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _table = 'cat_posts';

  Future<List<CatPost>> getCatPosts() async {
    try {
      final response = await _supabase
          .from(_table)
          .select()
          .order('created_at', ascending: false);
      
      return response
          .map((json) => CatPost.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch cat posts: $e');
    }
  }

  Future<void> createCatPost(CatPost post) async {
    try {
      await _supabase
          .from(_table)
          .insert(post.toJson());
    } catch (e) {
      throw Exception('Failed to create cat post: $e');
    }
  }

  Stream<List<CatPost>> getCatPostsStream() {
    return _supabase
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((rows) => rows
            .map((row) => CatPost.fromJson(row))
            .toList());
  }
}