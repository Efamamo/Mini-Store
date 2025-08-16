import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPageController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;
  var showSearch = false.obs;
  final RxList<String> searchHistory = <String>[].obs;
  final RxList<Map<String, dynamic>> searchResults =
      <Map<String, dynamic>>[].obs;
  final RxBool hasResults = false.obs;

  static const String _searchHistoryKey = 'search_history';
  static const int _maxHistoryItems = 10;

  // Sample products database for search
  final List<Map<String, dynamic>> allProducts = [
    {
      'id': 'PRD001',
      'name': 'Wireless Bluetooth Headphones',
      'price': 89.99,
      'originalPrice': 105.99,
      'image': 'assets/images/electronics.png',
      'category': 'Electronics',
      'brand': 'TechSound',
      'rating': 4.8,
      'reviews': 1247,
      'inStock': true,
      'discount': 15,
      'description':
          'Premium wireless headphones with active noise cancellation and 30-hour battery life.',
      'tags': [
        'wireless',
        'bluetooth',
        'headphones',
        'music',
        'audio',
        'noise cancellation',
      ],
    },
    {
      'id': 'PRD002',
      'name': 'Premium Cotton T-Shirt',
      'price': 29.99,
      'originalPrice': 35.99,
      'image': 'assets/images/clothes.png',
      'category': 'Fashion',
      'brand': 'StyleCo',
      'rating': 4.6,
      'reviews': 892,
      'inStock': true,
      'discount': 17,
      'description':
          'Comfortable premium cotton t-shirt available in multiple colors.',
      'tags': [
        't-shirt',
        'cotton',
        'clothing',
        'fashion',
        'casual',
        'comfortable',
      ],
    },
    {
      'id': 'PRD003',
      'name': 'Smart Fitness Watch',
      'price': 199.99,
      'originalPrice': 249.99,
      'image': 'assets/images/sport.png',
      'category': 'Sports',
      'brand': 'FitTech',
      'rating': 4.9,
      'reviews': 2156,
      'inStock': true,
      'discount': 20,
      'description':
          'Advanced fitness tracker with heart rate monitoring and GPS.',
      'tags': ['smartwatch', 'fitness', 'health', 'tracker', 'sports', 'GPS'],
    },
    {
      'id': 'PRD004',
      'name': 'Organic Face Cream',
      'price': 24.99,
      'originalPrice': 32.99,
      'image': 'assets/images/beauty.png',
      'category': 'Beauty',
      'brand': 'NaturalGlow',
      'rating': 4.7,
      'reviews': 634,
      'inStock': true,
      'discount': 24,
      'description':
          'Natural organic face cream for all skin types with vitamin E.',
      'tags': [
        'skincare',
        'organic',
        'face cream',
        'beauty',
        'natural',
        'moisturizer',
      ],
    },
    {
      'id': 'PRD005',
      'name': 'Gaming Laptop',
      'price': 899.99,
      'originalPrice': 1199.99,
      'image': 'assets/images/electronics.png',
      'category': 'Electronics',
      'brand': 'GameMax',
      'rating': 4.5,
      'reviews': 445,
      'inStock': true,
      'discount': 25,
      'description':
          'High-performance gaming laptop with RTX graphics and 16GB RAM.',
      'tags': ['laptop', 'gaming', 'computer', 'RTX', 'performance', 'RGB'],
    },
    {
      'id': 'PRD006',
      'name': 'Yoga Mat Premium',
      'price': 34.99,
      'originalPrice': 49.99,
      'image': 'assets/images/sport.png',
      'category': 'Sports',
      'brand': 'ZenFit',
      'rating': 4.4,
      'reviews': 789,
      'inStock': true,
      'discount': 30,
      'description':
          'Non-slip premium yoga mat with extra cushioning and carrying strap.',
      'tags': ['yoga', 'mat', 'exercise', 'fitness', 'meditation', 'non-slip'],
    },
    {
      'id': 'PRD007',
      'name': 'Coffee Maker Deluxe',
      'price': 159.99,
      'originalPrice': 199.99,
      'image': 'assets/images/construction.png',
      'category': 'Kitchen',
      'brand': 'BrewMaster',
      'rating': 4.6,
      'reviews': 567,
      'inStock': true,
      'discount': 20,
      'description':
          'Professional coffee maker with programmable settings and thermal carafe.',
      'tags': ['coffee', 'maker', 'kitchen', 'appliance', 'brew', 'automatic'],
    },
    {
      'id': 'PRD008',
      'name': 'Wireless Phone Charger',
      'price': 19.99,
      'originalPrice': 29.99,
      'image': 'assets/images/electronics.png',
      'category': 'Electronics',
      'brand': 'ChargeFast',
      'rating': 4.3,
      'reviews': 1123,
      'inStock': true,
      'discount': 33,
      'description':
          'Fast wireless charging pad compatible with all Qi-enabled devices.',
      'tags': ['wireless', 'charger', 'phone', 'fast charging', 'Qi', 'pad'],
    },
    {
      'id': 'PRD009',
      'name': 'Running Shoes',
      'price': 79.99,
      'originalPrice': 99.99,
      'image': 'assets/images/sport.png',
      'category': 'Sports',
      'brand': 'RunFast',
      'rating': 4.7,
      'reviews': 923,
      'inStock': true,
      'discount': 20,
      'description':
          'Lightweight running shoes with breathable mesh and cushioned sole.',
      'tags': [
        'shoes',
        'running',
        'sports',
        'comfortable',
        'lightweight',
        'breathable',
      ],
    },
    {
      'id': 'PRD010',
      'name': 'Moisturizing Lip Balm',
      'price': 4.99,
      'originalPrice': 7.99,
      'image': 'assets/images/beauty.png',
      'category': 'Beauty',
      'brand': 'SoftLips',
      'rating': 4.2,
      'reviews': 234,
      'inStock': true,
      'discount': 38,
      'description':
          'Nourishing lip balm with SPF protection and natural ingredients.',
      'tags': [
        'lip balm',
        'moisturizer',
        'SPF',
        'beauty',
        'natural',
        'protection',
      ],
    },
    {
      'id': 'PRD011',
      'name': 'Bluetooth Speaker',
      'price': 49.99,
      'originalPrice': 69.99,
      'image': 'assets/images/electronics.png',
      'category': 'Electronics',
      'brand': 'SoundMax',
      'rating': 4.5,
      'reviews': 678,
      'inStock': true,
      'discount': 29,
      'description':
          'Portable Bluetooth speaker with 360-degree sound and waterproof design.',
      'tags': [
        'speaker',
        'bluetooth',
        'portable',
        'waterproof',
        'music',
        'sound',
      ],
    },
    {
      'id': 'PRD012',
      'name': 'Denim Jacket',
      'price': 59.99,
      'originalPrice': 79.99,
      'image': 'assets/images/clothes.png',
      'category': 'Fashion',
      'brand': 'DenimCo',
      'rating': 4.4,
      'reviews': 345,
      'inStock': true,
      'discount': 25,
      'description':
          'Classic denim jacket with vintage wash and comfortable fit.',
      'tags': ['jacket', 'denim', 'fashion', 'vintage', 'casual', 'classic'],
    },
  ];

  @override
  void onInit() {
    super.onInit();
    // Listen to search text changes
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
    // Load search history when controller initializes
    loadSearchHistory();
  }

  @override
  void onReady() {
    super.onReady();
    // Auto-focus the search field when the page is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  // Load search history from SharedPreferences
  Future<void> loadSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList(_searchHistoryKey) ?? [];
      searchHistory.value = history;
    } catch (e) {
      print('Error loading search history: $e');
    }
  }

  // Save search query to history
  Future<void> saveToHistory(String query) async {
    if (query.trim().isEmpty) return;

    try {
      final trimmedQuery = query.trim();

      // Remove if already exists to avoid duplicates
      searchHistory.removeWhere(
        (item) => item.toLowerCase() == trimmedQuery.toLowerCase(),
      );

      // Add to beginning of list
      searchHistory.insert(0, trimmedQuery);

      // Keep only the latest items
      if (searchHistory.length > _maxHistoryItems) {
        searchHistory.removeRange(_maxHistoryItems, searchHistory.length);
      }

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_searchHistoryKey, searchHistory.toList());
    } catch (e) {
      print('Error saving search history: $e');
    }
  }

  // Clear search history
  Future<void> clearSearchHistory() async {
    try {
      searchHistory.clear();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_searchHistoryKey);
    } catch (e) {
      print('Error clearing search history: $e');
    }
  }

  // Remove specific item from history
  Future<void> removeFromHistory(String item) async {
    try {
      searchHistory.remove(item);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_searchHistoryKey, searchHistory.toList());
    } catch (e) {
      print('Error removing item from history: $e');
    }
  }

  void performSearch(String query) {
    if (query.trim().isNotEmpty) {
      // Save to history when search is performed
      saveToHistory(query);

      isSearching.value = true;

      Future.delayed(const Duration(milliseconds: 800), () {
        // Perform actual search
        searchResults.value = _searchProducts(query.trim());
        hasResults.value = searchResults.isNotEmpty;
        isSearching.value = false;
        showSearch.value = true;
      });
    }
  }

  List<Map<String, dynamic>> _searchProducts(String query) {
    final lowercaseQuery = query.toLowerCase();

    return allProducts.where((product) {
      // Search in product name
      if (product['name'].toLowerCase().contains(lowercaseQuery)) return true;

      // Search in category
      if (product['category'].toLowerCase().contains(lowercaseQuery))
        return true;

      // Search in brand
      if (product['brand'].toLowerCase().contains(lowercaseQuery)) return true;

      // Search in description
      if (product['description'].toLowerCase().contains(lowercaseQuery))
        return true;

      // Search in tags
      if ((product['tags'] as List<String>).any(
        (tag) => tag.toLowerCase().contains(lowercaseQuery),
      ))
        return true;

      return false;
    }).toList();
  }

  void navigateToProductDetail(Map<String, dynamic> product) {
    Get.toNamed('/product-detail', arguments: product);
  }

  void addToCart(Map<String, dynamic> product) {
    Get.snackbar(
      'Added to Cart',
      '${product['name']} added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  // Search from history item
  void searchFromHistory(String query) {
    searchController.text = query;
    searchQuery.value = query;
    performSearch(query);
  }
}
