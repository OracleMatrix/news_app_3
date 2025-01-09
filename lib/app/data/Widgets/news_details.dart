import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_3_update/app/data/Models/get_all_news_model.dart';
import 'package:news_app_3_update/app/data/Widgets/open_download_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({
    super.key,
    required this.isRTL,
    required this.article,
  });

  final bool isRTL;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isRTL
          ? CrossAxisAlignment.end // RTL alignment
          : CrossAxisAlignment.start, // LTR alignment
      children: [
        // Article Image with Zoom and Save Functionality
        if (article.urlToImage != null) OpenAndDownloadImages(article: article),

        // Article Title
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            article.title ?? 'No Title',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: isRTL ? TextAlign.right : TextAlign.left,
          ),
        ),

        // Article Description
        if (article.description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              article.description!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: isRTL ? TextAlign.right : TextAlign.left,
            ),
          ),

        // Article Content
        if (article.content != null && !isRTL)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              article.content!,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: isRTL ? TextAlign.right : TextAlign.left,
            ),
          ),

        // Source and Published Date
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.source?.name ?? 'Unknown Source',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: isRTL ? TextAlign.right : TextAlign.left,
              ),
              Text(
                article.publishedAt != null
                    ? '${article.publishedAt!.day}/${article.publishedAt!.month}/${article.publishedAt!.year} | ${article.publishedAt!.hour}:${article.publishedAt!.minute}'
                    : 'Unknown Date',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: isRTL ? TextAlign.right : TextAlign.left,
              ),
            ],
          ),
        ),

        // Open in Browser Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (article.url != null) {
                  if (!await launchUrl(
                    Uri.parse(article.url!),
                    mode: LaunchMode.inAppWebView,
                  )) {
                    Get.snackbar(
                      'Error',
                      'Could not open the article',
                      colorText: Colors.red,
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Read Full Article',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
