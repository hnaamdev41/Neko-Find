import 'package:get/get.dart';
import '../../data/models/cat_post.dart';
import '../../data/repositories/cat_repository.dart';

class HomeController extends GetxController {
  final CatRepository _catRepository = CatRepository();
  final RxList<CatPost> posts = <CatPost>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      posts.value = await _catRepository.getCatPosts();
    } finally {
      isLoading.value = false;
    }
  }
}
