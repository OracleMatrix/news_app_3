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
      } else if (response.status.hasError) {
        throw "Something went wrong\nPlease try again later or check your internet connection";
      } else if (response.status.isServerError) {
        throw 'The server is busy\nPlease try again later';
      } else if (response.status.isNotFound) {
        throw "Your request not found\nPlease try something else";
      } else {
        throw "Something went wrong\nPlease check your internet connection and try again";
      }
    } catch (e) {
      rethrow;
    }
  }
}
