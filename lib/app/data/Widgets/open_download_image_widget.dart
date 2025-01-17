import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:news_app_3_update/app/data/Models/get_all_news_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class OpenAndDownloadImages extends StatelessWidget {
  const OpenAndDownloadImages({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open the image in a zoomable view
        Get.to(
          () => Scaffold(
            appBar: AppBar(
              title: const Text('Image Preview'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () async {
                    try {
                      // Get the Downloads directory
                      final directory = await getDownloadsDirectory();
                      if (directory == null) {
                        Get.snackbar(
                            'Error', 'Could not access Downloads folder.');
                        return;
                      }

                      // Define the file name and path
                      final fileName =
                          'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
                      // final savePath = '${directory.path}/$fileName';

                      // Download the image
                      await FlutterDownloader.enqueue(
                        url: article.urlToImage!,
                        savedDir: directory.path,
                        fileName: fileName,
                        showNotification: true,
                        openFileFromNotification: true,
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'Failed to save image',
                        colorText: Colors.red,
                      );
                    }
                  },
                ),
              ],
            ),
            body: PhotoView(
              imageProvider: NetworkImage(article.urlToImage!),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        );
      },
      child: CachedNetworkImage(
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
        imageUrl: article.urlToImage!,
        placeholder: (context, url) => Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade600,
            child: Icon(
              Icons.broken_image_rounded,
              size: 60,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.broken_image_rounded,
          size: 60,
        ),
      ),
    );
  }
}
