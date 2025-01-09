import 'package:get/get.dart';

import '../../../data/Models/get_all_news_model.dart';

class NewsDetailsController extends GetxController {
  late Article article;

  @override
  void onInit() {
    super.onInit();
    article = Get.arguments as Article;
  }

  bool isRTL(String text) {
    final RegExp rtlRegex = RegExp(
        r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    return rtlRegex.hasMatch(text);
  }
}
