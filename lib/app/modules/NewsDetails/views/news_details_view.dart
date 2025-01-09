import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_3_update/app/data/Widgets/news_details.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/news_details_controller.dart';

class NewsDetailsView extends GetView<NewsDetailsController> {
  const NewsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final article = controller.article;

    // Check if the text is RTL
    final bool isRTL = controller.isRTL(article.title ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.source?.name ?? 'News Details',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share('Check out this news article: ${article.url}');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: NewsDetails(isRTL: isRTL, article: article),
      ),
    );
  }
}
