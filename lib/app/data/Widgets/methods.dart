import 'package:flutter/material.dart';
import 'package:news_app_3_update/app/modules/home/controllers/home_controller.dart';

Widget buildCategoryChip(String category, HomeController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: GestureDetector(
      onTap: () {
        controller.fetchNews(query: category);
      },
      child: Chip(
        label: Text(category),
        backgroundColor: Colors.grey.shade900,
      ),
    ),
  );
}
