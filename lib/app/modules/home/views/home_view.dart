import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_3_update/app/data/Widgets/methods.dart';
import 'package:news_app_3_update/app/data/Widgets/news_card.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.fetchNews(),
        child: CustomScrollView(
          slivers: [
            // SliverAppBar for the scrollable AppBar
            SliverAppBar(
              centerTitle: true,
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
                                controller.fetchNews(query: 'Global');
                              }
                            },
                          ),
                        ),
                        onSubmitted: (query) {
                          if (query.isNotEmpty) {
                            controller.fetchNews(query: query);
                          } else {
                            controller.fetchNews(query: 'Global');
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
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade800,
                    highlightColor: Colors.grey.shade600,
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: 2,
                      itemBuilder: (context, index) => SizedBox(
                        height: Get.height * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(),
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
