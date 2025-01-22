import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image/image.dart' as img;
import '../../core/constants/app_constants.dart';

class StorageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> uploadImage(File file) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final bytes = await _compressImage(file);
      
      await _supabase.storage
          .from(AppConstants.supabaseImageBucket)
          .uploadBinary(
            fileName, 
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true
            ),
          );
          
      return _supabase.storage
          .from(AppConstants.supabaseImageBucket)
          .getPublicUrl(fileName);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<Uint8List> _compressImage(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) throw Exception('Invalid image file');
    
    final compressedBytes = img.encodeJpg(image, quality: 70);
    return Uint8List.fromList(compressedBytes);
  }
}