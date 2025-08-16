import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProductsController extends GetxController {
  var selectedTabIndex = 0.obs;
  var selectedViewMode = 0.obs; // 0: Grid, 1: List
  var searchQuery = ''.obs;
  var selectedFilterIndex = 0.obs;
  var isLoading = false.obs;

  // Tab options
  final List<String> tabs = ['All Products', 'Active', 'Draft', 'Out of Stock'];

  // Filter options
  final List<String> filterOptions = [
    'All',
    'Recent',
    'Best Selling',
    'Low Stock',
    'High Price',
    'Low Price',
  ];

  // Sample products data
  final List<Map<String, dynamic>> allProducts = [
    {
      'id': 'PRD001',
      'name': 'Wireless Bluetooth Headphones',
      'price': 89.99,
      'originalPrice': 105.99,
      'image': 'assets/images/electronics.png',
      'category': 'Electronics',
      'stock': 45,
      'sold': 127,
      'rating': 4.8,
      'reviews': 1247,
      'status': 'active',
      'createdAt': DateTime.now().subtract(const Duration(days: 15)),
      'lastModified': DateTime.now().subtract(const Duration(days: 2)),
      'isPopular': true,
      'discount': 15,
    },
    {
      'id': 'PRD002',
      'name': 'Premium Cotton T-Shirt',
      'price': 29.99,
      'originalPrice': 35.99,
      'image': 'assets/images/clothes.png',
      'category': 'Fashion',
      'stock': 0,
      'sold': 89,
      'rating': 4.6,
      'reviews': 892,
      'status': 'out_of_stock',
      'createdAt': DateTime.now().subtract(const Duration(days: 30)),
      'lastModified': DateTime.now().subtract(const Duration(days: 1)),
      'isPopular': false,
      'discount': 17,
    },
    {
      'id': 'PRD003',
      'name': 'Smart Fitness Watch',
      'price': 199.99,
      'originalPrice': 249.99,
      'image': 'assets/images/sport.png',
      'category': 'Sports',
      'stock': 23,
      'sold': 156,
      'rating': 4.9,
      'reviews': 2156,
      'status': 'active',
      'createdAt': DateTime.now().subtract(const Duration(days: 5)),
      'lastModified': DateTime.now().subtract(const Duration(hours: 3)),
      'isPopular': true,
      'discount': 20,
    },
    {
      'id': 'PRD004',
      'name': 'Organic Face Cream',
      'price': 24.99,
      'originalPrice': 32.99,
      'image': 'assets/images/beauty.png',
      'category': 'Beauty',
      'stock': 12,
      'sold': 78,
      'rating': 4.7,
      'reviews': 634,
      'status': 'active',
      'createdAt': DateTime.now().subtract(const Duration(days: 20)),
      'lastModified': DateTime.now().subtract(const Duration(days: 5)),
      'isPopular': false,
      'discount': 24,
    },
    {
      'id': 'PRD005',
      'name': 'Professional Kitchen Knife Set',
      'price': 79.99,
      'originalPrice': 99.99,
      'image': 'assets/images/construction.png',
      'category': 'Kitchen',
      'stock': 34,
      'sold': 45,
      'rating': 4.5,
      'reviews': 456,
      'status': 'draft',
      'createdAt': DateTime.now().subtract(const Duration(days: 8)),
      'lastModified': DateTime.now().subtract(const Duration(hours: 12)),
      'isPopular': false,
      'discount': 20,
    },
    {
      'id': 'PRD006',
      'name': 'Gourmet Coffee Beans',
      'price': 18.99,
      'originalPrice': 22.99,
      'image': 'assets/images/food.png',
      'category': 'Food',
      'stock': 67,
      'sold': 234,
      'rating': 4.4,
      'reviews': 289,
      'status': 'active',
      'createdAt': DateTime.now().subtract(const Duration(days: 12)),
      'lastModified': DateTime.now().subtract(const Duration(days: 1)),
      'isPopular': true,
      'discount': 17,
    },
  ];

  var filteredProducts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredProducts.value = allProducts;
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
    _applyFilters();
  }

  void toggleViewMode() {
    selectedViewMode.value = selectedViewMode.value == 0 ? 1 : 0;
  }

  void selectFilter(int index) {
    selectedFilterIndex.value = index;
    _applyFilters();
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void _applyFilters() {
    var products = List<Map<String, dynamic>>.from(allProducts);

    // Apply tab filter
    switch (selectedTabIndex.value) {
      case 1: // Active
        products = products.where((p) => p['status'] == 'active').toList();
        break;
      case 2: // Draft
        products = products.where((p) => p['status'] == 'draft').toList();
        break;
      case 3: // Out of Stock
        products =
            products.where((p) => p['status'] == 'out_of_stock').toList();
        break;
    }

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      products =
          products
              .where(
                (p) =>
                    p['name'].toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ) ||
                    p['category'].toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ),
              )
              .toList();
    }

    // Apply sorting based on filter
    switch (selectedFilterIndex.value) {
      case 1: // Recent
        products.sort((a, b) => b['lastModified'].compareTo(a['lastModified']));
        break;
      case 2: // Best Selling
        products.sort((a, b) => b['sold'].compareTo(a['sold']));
        break;
      case 3: // Low Stock
        products.sort((a, b) => a['stock'].compareTo(b['stock']));
        break;
      case 4: // High Price
        products.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 5: // Low Price
        products.sort((a, b) => a['price'].compareTo(b['price']));
        break;
    }

    filteredProducts.value = products;
  }

  void navigateToAddProduct() {
    Get.toNamed('/add-product');
  }

  void editProduct(Map<String, dynamic> product) {
    Get.toNamed(
      '/add-product',
      arguments: {'mode': 'edit', 'product': product},
    );
  }

  void duplicateProduct(Map<String, dynamic> product) {
    Get.snackbar(
      'Product Duplicated',
      '${product['name']} has been duplicated',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void deleteProduct(Map<String, dynamic> product) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product['name']}"?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              allProducts.removeWhere((p) => p['id'] == product['id']);
              _applyFilters();
              Get.back();
              Get.snackbar(
                'Product Deleted',
                '${product['name']} has been deleted',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void toggleProductStatus(Map<String, dynamic> product) {
    if (product['status'] == 'active') {
      product['status'] = 'draft';
    } else {
      product['status'] = 'active';
    }
    _applyFilters();

    Get.snackbar(
      'Status Updated',
      'Product status changed to ${product['status']}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF3B82F6),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  String get currentFilter => filterOptions[selectedFilterIndex.value];

  int get totalProducts => allProducts.length;
  int get activeProducts =>
      allProducts.where((p) => p['status'] == 'active').length;
  int get draftProducts =>
      allProducts.where((p) => p['status'] == 'draft').length;
  int get outOfStockProducts =>
      allProducts.where((p) => p['status'] == 'out_of_stock').length;

  double get totalRevenue =>
      allProducts.fold(0.0, (sum, p) => sum + (p['price'] * p['sold']));
  int get totalSold =>
      allProducts.fold(0, (sum, p) => sum + (p['sold'] as int));
}
