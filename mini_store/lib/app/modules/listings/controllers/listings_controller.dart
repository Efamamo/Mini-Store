import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListingsController extends GetxController {
  var selectedSortIndex = 0.obs;
  var selectedFilterIndex = 0.obs;
  var searchQuery = ''.obs;
  var isGridView = true.obs;
  var categoryTitle = ''.obs;
  var isLoading = false.obs;

  // Sort options
  final List<String> sortOptions = [
    'Popular',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
    'Rating',
    'Name A-Z',
  ];

  // Filter options
  final List<String> filterOptions = [
    'All',
    'Free Shipping',
    'On Sale',
    'In Stock',
    'New Arrivals',
    'Top Rated',
  ];

  // All products data
  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'Wireless Bluetooth Headphones',
      'price': 89.99,
      'originalPrice': 105.99,
      'image': 'assets/images/electronics.png',
      'rating': 4.8,
      'reviews': 1247,
      'isNew': true,
      'discount': 15,
      'category': 'Electronics',
      'brand': 'TechSound',
      'inStock': true,
      'freeShipping': true,
      'isFavorite': false,
    },
    {
      'name': 'Premium Cotton T-Shirt',
      'price': 29.99,
      'originalPrice': 35.99,
      'image': 'assets/images/clothes.png',
      'rating': 4.6,
      'reviews': 892,
      'isNew': false,
      'discount': 17,
      'category': 'Fashion',
      'brand': 'StyleCo',
      'inStock': true,
      'freeShipping': false,
      'isFavorite': false,
    },
    {
      'name': 'Smart Fitness Watch',
      'price': 199.99,
      'originalPrice': 249.99,
      'image': 'assets/images/sport.png',
      'rating': 4.9,
      'reviews': 2156,
      'isNew': true,
      'discount': 20,
      'category': 'Sports & Fitness',
      'brand': 'FitTech',
      'inStock': true,
      'freeShipping': true,
      'isFavorite': false,
    },
    {
      'name': 'Organic Face Cream',
      'price': 24.99,
      'originalPrice': 32.99,
      'image': 'assets/images/beauty.png',
      'rating': 4.7,
      'reviews': 634,
      'isNew': false,
      'discount': 24,
      'category': 'Beauty & Health',
      'brand': 'PureGlow',
      'inStock': true,
      'freeShipping': false,
      'isFavorite': true,
    },
    {
      'name': 'Professional Kitchen Knife Set',
      'price': 79.99,
      'originalPrice': 99.99,
      'image': 'assets/images/construction.png',
      'rating': 4.5,
      'reviews': 456,
      'isNew': false,
      'discount': 20,
      'category': 'Home & Garden',
      'brand': 'ChefMaster',
      'inStock': true,
      'freeShipping': true,
      'isFavorite': false,
    },
    {
      'name': 'Gourmet Coffee Beans',
      'price': 18.99,
      'originalPrice': 22.99,
      'image': 'assets/images/food.png',
      'rating': 4.4,
      'reviews': 289,
      'isNew': true,
      'discount': 17,
      'category': 'Food & Beverages',
      'brand': 'RoastCo',
      'inStock': false,
      'freeShipping': false,
      'isFavorite': false,
    },
    {
      'name': 'Educational Building Blocks',
      'price': 34.99,
      'originalPrice': 44.99,
      'image': 'assets/images/toys.png',
      'rating': 4.8,
      'reviews': 723,
      'isNew': false,
      'discount': 22,
      'category': 'Toys & Games',
      'brand': 'LearnFun',
      'inStock': true,
      'freeShipping': true,
      'isFavorite': false,
    },
    {
      'name': 'Car Phone Mount',
      'price': 15.99,
      'originalPrice': 19.99,
      'image': 'assets/images/vehicle.png',
      'rating': 4.3,
      'reviews': 178,
      'isNew': false,
      'discount': 20,
      'category': 'Automotive',
      'brand': 'DriveGear',
      'inStock': true,
      'freeShipping': false,
      'isFavorite': false,
    },
  ];

  var filteredProducts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Get arguments from navigation
    final args = Get.arguments;
    if (args != null && args['category'] != null) {
      categoryTitle.value = args['category'];
      // Filter products by category
      filteredProducts.value =
          allProducts
              .where((product) => product['category'] == args['category'])
              .toList();
    } else {
      categoryTitle.value = 'All Products';
      filteredProducts.value = allProducts;
    }
  }

  void selectSort(int index) {
    selectedSortIndex.value = index;
    _applySorting();
  }

  void selectFilter(int index) {
    selectedFilterIndex.value = index;
    _applyFiltering();
  }

  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    _applyFiltering();
  }

  void toggleFavorite(int index) {
    filteredProducts[index]['isFavorite'] =
        !filteredProducts[index]['isFavorite'];
    filteredProducts.refresh();
  }

  void _applySorting() {
    switch (selectedSortIndex.value) {
      case 0: // Popular
        filteredProducts.sort((a, b) => b['reviews'].compareTo(a['reviews']));
        break;
      case 1: // Price: Low to High
        filteredProducts.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 2: // Price: High to Low
        filteredProducts.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 3: // Newest
        filteredProducts.sort((a, b) => b['isNew'] ? 1 : -1);
        break;
      case 4: // Rating
        filteredProducts.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 5: // Name A-Z
        filteredProducts.sort((a, b) => a['name'].compareTo(b['name']));
        break;
    }
    filteredProducts.refresh();
  }

  void _applyFiltering() {
    var products = allProducts;

    // Apply category filter if set
    final args = Get.arguments;
    if (args != null && args['category'] != null) {
      products =
          products
              .where((product) => product['category'] == args['category'])
              .toList();
    }

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      products =
          products
              .where(
                (product) =>
                    product['name'].toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ) ||
                    product['brand'].toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ),
              )
              .toList();
    }

    // Apply additional filters
    switch (selectedFilterIndex.value) {
      case 1: // Free Shipping
        products =
            products
                .where((product) => product['freeShipping'] == true)
                .toList();
        break;
      case 2: // On Sale
        products =
            products.where((product) => product['discount'] > 0).toList();
        break;
      case 3: // In Stock
        products =
            products.where((product) => product['inStock'] == true).toList();
        break;
      case 4: // New Arrivals
        products =
            products.where((product) => product['isNew'] == true).toList();
        break;
      case 5: // Top Rated
        products =
            products.where((product) => product['rating'] >= 4.5).toList();
        break;
    }

    filteredProducts.value = products;
    _applySorting();
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

  String get currentFilter => filterOptions[selectedFilterIndex.value];
  String get currentSort => sortOptions[selectedSortIndex.value];
}
