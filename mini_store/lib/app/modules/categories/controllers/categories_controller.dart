import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_store/app/routes/app_pages.dart';

class CategoriesController extends GetxController {
  var selectedCategoryIndex = 0.obs;
  var searchQuery = ''.obs;
  var isGridView = true.obs;

  // All categories data
  final List<Map<String, dynamic>> allCategories = [
    {
      'name': 'Electronics',
      'icon': Icons.devices,
      'color': const Color(0xFF3B82F6),
      'image': 'assets/images/electronics.png',
      'count': 234,
      'trending': true,
      'subcategories': [
        'Smartphones',
        'Laptops',
        'Headphones',
        'Cameras',
        'Tablets',
      ],
    },
    {
      'name': 'Fashion',
      'icon': Icons.checkroom,
      'color': const Color(0xFFEC4899),
      'image': 'assets/images/clothes.png',
      'count': 189,
      'trending': false,
      'subcategories': [
        'Men\'s Clothing',
        'Women\'s Clothing',
        'Shoes',
        'Accessories',
        'Bags',
      ],
    },
    {
      'name': 'Home & Garden',
      'icon': Icons.home,
      'color': const Color(0xFF10B981),
      'image': 'assets/images/construction.png',
      'count': 156,
      'trending': true,
      'subcategories': [
        'Furniture',
        'Garden Tools',
        'Home Decor',
        'Kitchen',
        'Bedding',
      ],
    },
    {
      'name': 'Sports & Fitness',
      'icon': Icons.sports_soccer,
      'color': const Color(0xFFF59E0B),
      'image': 'assets/images/sport.png',
      'count': 98,
      'trending': false,
      'subcategories': [
        'Exercise Equipment',
        'Sports Gear',
        'Outdoor Activities',
        'Fitness Accessories',
      ],
    },
    {
      'name': 'Beauty & Health',
      'icon': Icons.face,
      'color': const Color(0xFF8B5CF6),
      'image': 'assets/images/beauty.png',
      'count': 145,
      'trending': true,
      'subcategories': [
        'Skincare',
        'Makeup',
        'Hair Care',
        'Supplements',
        'Personal Care',
      ],
    },
    {
      'name': 'Food & Beverages',
      'icon': Icons.restaurant,
      'color': const Color(0xFFEF4444),
      'image': 'assets/images/food.png',
      'count': 78,
      'trending': false,
      'subcategories': [
        'Fresh Produce',
        'Snacks',
        'Beverages',
        'Dairy',
        'Frozen Foods',
      ],
    },
    {
      'name': 'Books & Media',
      'icon': Icons.book,
      'color': const Color(0xFF06B6D4),
      'image': 'assets/images/office.png',
      'count': 67,
      'trending': false,
      'subcategories': [
        'Fiction',
        'Non-Fiction',
        'Educational',
        'Comics',
        'Audiobooks',
      ],
    },
    {
      'name': 'Toys & Games',
      'icon': Icons.toys,
      'color': const Color(0xFFF97316),
      'image': 'assets/images/toys.png',
      'count': 123,
      'trending': true,
      'subcategories': [
        'Action Figures',
        'Board Games',
        'Educational Toys',
        'Video Games',
        'Puzzles',
      ],
    },
    {
      'name': 'Automotive',
      'icon': Icons.directions_car,
      'color': const Color(0xFF64748B),
      'image': 'assets/images/vehicle.png',
      'count': 89,
      'trending': false,
      'subcategories': [
        'Car Parts',
        'Tools',
        'Accessories',
        'Maintenance',
        'Electronics',
      ],
    },
    {
      'name': 'Pet Supplies',
      'icon': Icons.pets,
      'color': const Color(0xFF84CC16),
      'image': 'assets/images/pets.png',
      'count': 56,
      'trending': false,
      'subcategories': [
        'Dog Supplies',
        'Cat Supplies',
        'Bird Supplies',
        'Fish Supplies',
        'Small Pets',
      ],
    },
  ];

  var filteredCategories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCategories.value = allCategories;
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  void searchCategories(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCategories.value = allCategories;
    } else {
      filteredCategories.value =
          allCategories
              .where(
                (category) =>
                    category['name'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    category['subcategories'].any(
                      (sub) => sub.toLowerCase().contains(query.toLowerCase()),
                    ),
              )
              .toList();
    }
  }

  void navigateToListings(Map<String, dynamic> category) {
    Get.toNamed(
      Routes.LISTINGS,
      arguments: {'category': category['name'], 'categoryData': category},
    );
  }

  List<Map<String, dynamic>> get trendingCategories {
    return allCategories
        .where((category) => category['trending'] == true)
        .toList();
  }

  List<Map<String, dynamic>> get topCategories {
    var sorted = [...allCategories];
    sorted.sort((a, b) => b['count'].compareTo(a['count']));
    return sorted.take(5).toList();
  }
}
