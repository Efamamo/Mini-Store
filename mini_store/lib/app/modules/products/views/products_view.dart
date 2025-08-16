import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_store/app/routes/app_pages.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Static data for categories
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Electronics',
        'icon': Icons.devices,
        'color': const Color(0xFF3B82F6),
        'image': 'assets/images/electronics.png',
      },
      {
        'name': 'Fashion',
        'icon': Icons.checkroom,
        'color': const Color(0xFFEC4899),
        'image': 'assets/images/clothes.png',
      },
      {
        'name': 'Home & Garden',
        'icon': Icons.home,
        'color': const Color(0xFF10B981),
        'image': 'assets/images/construction.png',
      },
      {
        'name': 'Sports',
        'icon': Icons.sports_soccer,
        'color': const Color(0xFFF59E0B),
        'image': 'assets/images/sport.png',
      },
      {
        'name': 'Beauty',
        'icon': Icons.face,
        'color': const Color(0xFF8B5CF6),
        'image': 'assets/images/beauty.png',
      },
      {
        'name': 'Food',
        'icon': Icons.restaurant,
        'color': const Color(0xFFEF4444),
        'image': 'assets/images/food.png',
      },
    ];

    // Static data for featured products
    final List<Map<String, dynamic>> featuredProducts = [
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
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SEARCH_PAGE);
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Hero Banner Section
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Special Offer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Get 50% OFF\non Electronics',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Shop Now',
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),

            // Categories Section
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 8),
              child: Row(
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.CATEGORIES);
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: const Color(0xFF667EEA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            // Categories Grid
            Container(
              height: 120,
              margin: const EdgeInsets.only(bottom: 24),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      controller.navigateToListings(category);
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  category['color'],
                                  category['color'].withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: category['color'].withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              category['icon'],
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['name'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Featured Products Section
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 16),
              child: Row(
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.LISTINGS);
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: const Color(0xFF667EEA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            // Featured Products Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.67, // Adjusted for better proportions
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  final product = featuredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(product['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Product Info
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: const Color(0xFFF59E0B),
                                        size: 12,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${product['rating']}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${product['reviews']})',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\$${product['price'].toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF10B981),
                                              ),
                                            ),
                                            if (product['discount'] > 0)
                                              Text(
                                                '\$${product['originalPrice'].toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[500],
                                                  decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF3B82F6),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom spacing
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
