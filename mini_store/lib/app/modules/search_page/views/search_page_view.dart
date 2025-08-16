import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Search Field
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    focusNode: controller.searchFocusNode,
                    onSubmitted: controller.performSearch,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                      controller.showSearch.value = false;
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for products',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      prefixIcon: Container(
                        margin: const EdgeInsets.all(12),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      ),
                      suffixIcon:
                          controller.searchQuery.value.isNotEmpty
                              ? GestureDetector(
                                onTap: controller.clearSearch,
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.grey[400],
                                ),
                              )
                              : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Search Suggestions (when typing but not submitted)
            Obx(() {
              if (!controller.showSearch.value &&
                  controller.searchQuery.value.isNotEmpty &&
                  controller.searchHistory.isNotEmpty) {
                final suggestions =
                    controller.searchHistory
                        .where(
                          (item) => item.toLowerCase().contains(
                            controller.searchQuery.value.toLowerCase(),
                          ),
                        )
                        .take(5)
                        .toList();

                if (suggestions.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...suggestions.map(
                          (suggestion) => ListTile(
                            leading: Icon(
                              Icons.search,
                              color: Colors.grey[600],
                              size: 18,
                            ),
                            title: Text(
                              suggestion,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                            trailing: Icon(
                              Icons.north_west,
                              color: Colors.grey[600],
                              size: 16,
                            ),

                            onTap:
                                () => controller.searchFromHistory(suggestion),
                            contentPadding: const EdgeInsets.only(
                              left: 16,
                              right: 0,
                              top: 0,
                              bottom: 0,
                            ),
                            dense: true,
                            minVerticalPadding: 0,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            }),

            Expanded(
              child: Obx(() {
                if (controller.isSearching.value) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xFF3B82F6),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Searching...',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.searchQuery.value.isEmpty) {
                  return Obx(() {
                    if (controller.searchHistory.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.searchHistory.length,
                                itemBuilder: (context, index) {
                                  final historyItem =
                                      controller.searchHistory[index];
                                  return ListTile(
                                    leading: Icon(
                                      Icons.history,
                                      color: Colors.grey[600],
                                      size: 18,
                                    ),
                                    title: Text(
                                      historyItem,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.grey[400],
                                      ),
                                      onPressed:
                                          () => controller.removeFromHistory(
                                            historyItem,
                                          ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                    ),
                                    onTap:
                                        () => controller.searchFromHistory(
                                          historyItem,
                                        ),
                                    contentPadding: const EdgeInsets.only(
                                      left: 16,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                    ),
                                    dense: true,
                                    minVerticalPadding: 0,
                                    visualDensity: VisualDensity.compact,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 80,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Start typing to search',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Find products, stores, and services',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                }

                if (controller.showSearch.value) {
                  if (controller.hasResults.value) {
                    return _buildSearchResults();
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No results found for "${controller.searchQuery.value}"',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try different keywords or check spelling',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 80, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text(
                        'Press search to see results',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      children: [
        // Results Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Obx(
                () => Text(
                  '${controller.searchResults.length} results for "${controller.searchQuery.value}"',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 16,
                      color: const Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFF3B82F6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Products Grid
        Expanded(
          child: Obx(
            () => GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: controller.searchResults.length,
              itemBuilder: (context, index) {
                final product = controller.searchResults[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => controller.navigateToProductDetail(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
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

                  // Favorite Button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: Colors.grey[600],
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Text(
                      product['brand'],
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFF3B82F6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Product Name
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const Spacer(),

                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: const Color(0xFFF59E0B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating']}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
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

                    const SizedBox(height: 8),

                    // Price and Add to Cart
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product['discount'] > 0) ...[
                                Text(
                                  '\$${product['originalPrice'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[500],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(height: 2),
                              ],
                              Text(
                                '\$${product['price'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () => controller.addToCart(product),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF10B981), Color(0xFF059669)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              size: 16,
                              color: Colors.white,
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
  }
}
