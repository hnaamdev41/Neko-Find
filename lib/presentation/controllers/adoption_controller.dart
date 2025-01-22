// lib/presentation/controllers/adoption_controller.dart
import 'package:get/get.dart';
import '../../data/models/cat_post.dart';
import '../../data/repositories/cat_repository.dart';

class AdoptionController extends GetxController {
  final _catRepository = CatRepository();
  final adoptableCats = <CatPost>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdoptableCats();
  }

  Future<void> fetchAdoptableCats() async {
    isLoading.value = true;
    try {
      final cats = await _catRepository.getCatPosts();
      adoptableCats.value = cats;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch cats: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}