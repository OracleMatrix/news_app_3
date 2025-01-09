// ignore_for_file: prefer_final_fields

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:news_app_3_update/app/data/Models/get_all_news_model.dart';
import 'package:news_app_3_update/app/data/Services/get_all_news_api_service.dart';

class HomeController extends GetxController {
  final GetAllNewsApiService _apiService = GetAllNewsApiService();
  var searchController = TextEditingController().obs;
  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  set isLoading(var value) => _isLoading.value = value;

  var _articles = <Article>[].obs;
  var allData = GetAllNewsModel().obs;
  get articles => _articles;

  set articles(var value) => _articles.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchNews(); // Initial fetch
  }

  Future<GetAllNewsModel?> fetchNews({String query = 'Global'}) async {
    try {
      _isLoading.value = true;
      final data = await _apiService.getAllNews(query);
      if (data != null) {
        _articles.value = data.articles!;
        allData.value = data;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
    return null;
  }

  bool isRTL(String text) {
    final RegExp rtlRegex = RegExp(
        r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    return rtlRegex.hasMatch(text);
  }
}
