import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_3_update/app/data/Constants/api_key.dart';
import 'package:news_app_3_update/app/data/Constants/base_url.dart';
import 'package:news_app_3_update/app/data/Models/get_all_news_model.dart';

class GetAllNewsApiService extends GetConnect {
  Future<GetAllNewsModel?> getAllNews(String query) async {
    try {
      final response = await get(
        "${BaseUrl.baseUrl}everything?q=$query&sortBy=publishedAt&apiKey=${ApiKey.apiKey}",
      );

      if (response.status.isOk) {
        return getAllNewsModelFromJson(response.bodyString!);
      } else if (response.status.isForbidden) {
        Get.snackbar(
          'Error',
          '${response.body?['message'] ?? response.statusText}',
          colorText: Colors.red,
        );
      } else if (response.status.isNotFound) {
        Get.snackbar(
          'Error',
          '${response.body?['message'] ?? response.statusText}',
          colorText: Colors.red,
        );
      } else if (response.status.isUnauthorized) {
        Get.snackbar(
          duration: const Duration(seconds: 5),
          'Error',
          '${response.body?['message'] ?? response.statusText}',
          colorText: Colors.red,
        );
      } else if (response.status.isServerError) {
        Get.snackbar(
          duration: const Duration(seconds: 5),
          'Error',
          '${response.body?['message'] ?? response.statusText}',
          colorText: Colors.red,
        );
      } else if (response.status.hasError) {
        Get.snackbar(
          duration: const Duration(seconds: 5),
          'Error',
          '${response.body?['message'] ?? 'Something went wrong\nPlease check your internet connection'}',
          colorText: Colors.red,
        );
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          duration: const Duration(seconds: 5),
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
