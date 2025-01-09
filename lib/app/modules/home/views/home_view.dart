import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_3_update/app/data/Widgets/methods.dart';
import 'package:news_app_3_update/app/data/Widgets/news_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar for the scrollable AppBar
          SliverAppBar(
            centerTitle: true,
            snap: true,
            floating: true,
            elevation: 0,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  SizedBox(height: 40),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller.searchController.value,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Search for news...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            final query =
                                controller.searchController.value.text;
                            if (query.isNotEmpty) {
                              controller.fetchNews(query: query);
                            } else {
                              Get.snackbar(
                                'Error',
                                'Please enter a search term',
                                colorText: Colors.red,
                              );
                            }
                          },
                        ),
                      ),
                      onSubmitted: (query) {
                        if (query.isNotEmpty) {
                          controller.fetchNews(query: query);
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please enter a search term',
                            colorText: Colors.red,
                          );
                        }
                      },
                    ),
                  ),
                  // Categories
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildCategoryChip('🌍 Global', controller),
                        buildCategoryChip('💻 Technology', controller),
                        buildCategoryChip('💼 Business', controller),
                        buildCategoryChip('🏥 Health', controller),
                        buildCategoryChip('⚽ Sports', controller),
                        buildCategoryChip('🎬 Entertainment', controller),
                        buildCategoryChip('🔬 Science', controller),
                        buildCategoryChip('🌦️ Weather', controller),
                        buildCategoryChip('🎮Gaming', controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SliverList for the news items
          Obx(() {
            if (controller.isLoading) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                    strokeWidth: 4.0,
                  ),
                ),
              );
            } else if (controller.articles.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No Data Found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Try searching for something else.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final article = controller.articles[index];
                  if (article.title?.toLowerCase() == '[removed]') {
                    return const SizedBox.shrink();
                  }
                  final bool isRTL = controller.isRTL(article.title ?? '');
                  return NewsCard(article: article, isRTL: isRTL);
                },
                childCount: controller.articles.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}
