import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_3_update/app/routes/app_pages.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.article,
    required this.isRTL,
  });

  final dynamic article;
  final bool isRTL;
  String truncateToThreeWords(String text) {
    List<String> words = text.split(' ');
    if (words.length > 3) {
      return '${words.take(3).join(' ')}...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.toNamed(
            Routes.NEWS_DETAILS,
            arguments: article,
          );
        },
        onLongPress: () {
          Share.share('Check out this news article: ${article.url}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  width: Get.width,
                  height: Get.height * 0.2,
                  fit: BoxFit.cover,
                  imageUrl: article.urlToImage ?? '',
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey.shade400,
                      ),
                    );
                  },
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade800,
                      highlightColor: Colors.grey.shade600,
                      child: Icon(
                        Icons.broken_image_rounded,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: isRTL
                    ? CrossAxisAlignment.end // RTL alignment
                    : CrossAxisAlignment.start, // LTR alignment
                children: [
                  // Article Title
                  Text(
                    article.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  // Article Description
                  Text(
                    article.description ?? 'No Description',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  // Source and Published Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        truncateToThreeWords(
                            article.source?.name ?? 'Unknown Source'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: isRTL ? TextAlign.right : TextAlign.left,
                      ),
                      Text(
                        article.publishedAt != null
                            ? timeago.format(article.publishedAt)
                            : 'Unknown Date',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: isRTL ? TextAlign.right : TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
