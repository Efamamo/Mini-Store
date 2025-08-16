import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailController extends GetxController {
  // Product data (can be passed from previous screen)
  var product = {}.obs;

  // UI state
  var selectedImageIndex = 0.obs;
  var quantity = 1.obs;
  var selectedColorIndex = 0.obs;
  var selectedSizeIndex = 0.obs;
  var isFavorite = false.obs;
  var userRating = 0.0.obs;
  var isLoading = false.obs;

  // Product images
  var productImages = <String>[].obs;

  // Available colors and sizes
  var availableColors = <Map<String, dynamic>>[].obs;
  var availableSizes = <String>[].obs;

  // Reviews
  var reviews = <Map<String, dynamic>>[].obs;
  var showAllReviews = false.obs;
  var isWritingReview = false.obs;
  var userReviewText = ''.obs;
  var userReviewRating = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeProduct();
  }

  void _initializeProduct() {
    // Get product data from arguments or use default
    if (Get.arguments != null) {
      product.value = Get.arguments;
    } else {
      // Default product data for demo
      product.value = {
        'name': 'Wireless Bluetooth Headphones',
        'price': 89.99,
        'originalPrice': 105.99,
        'image': 'assets/images/electronics.png',
        'rating': 4.8,
        'reviews': 1247,
        'description':
            'Premium wireless headphones with active noise cancellation, 30-hour battery life, and superior sound quality. Perfect for music lovers and professionals.',
        'brand': 'TechSound',
        'category': 'Electronics',
        'isNew': true,
        'discount': 15,
        'inStock': true,
        'stockCount': 23,
      };
    }

    // Initialize product images
    productImages.value = [
      product['image'] ?? 'assets/images/electronics.png',
      'assets/images/electronics.png',
      'assets/images/sport.png',
      'assets/images/beauty.png',
    ];

    // Initialize available colors
    availableColors.value = [
      {'name': 'Black', 'color': Colors.black},
      {'name': 'White', 'color': Colors.white},
      {'name': 'Blue', 'color': const Color(0xFF3B82F6)},
      {'name': 'Red', 'color': const Color(0xFFEF4444)},
    ];

    // Initialize available sizes
    availableSizes.value = ['S', 'M', 'L', 'XL'];

    // Initialize reviews
    reviews.value = [
      {
        'user': 'John Doe',
        'rating': 5.0,
        'comment': 'Amazing quality! Highly recommended.',
        'date': '2 days ago',
        'avatar': 'JD',
      },
      {
        'user': 'Sarah Wilson',
        'rating': 4.0,
        'comment': 'Good product, fast delivery.',
        'date': '1 week ago',
        'avatar': 'SW',
      },
      {
        'user': 'Mike Johnson',
        'rating': 5.0,
        'comment': 'Excellent build quality and great value for money.',
        'date': '2 weeks ago',
        'avatar': 'MJ',
      },
    ];
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void selectColor(int index) {
    selectedColorIndex.value = index;
  }

  void selectSize(int index) {
    selectedSizeIndex.value = index;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    Get.snackbar(
      isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites',
      isFavorite.value
          ? 'Product added to your favorites'
          : 'Product removed from favorites',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isFavorite.value ? Colors.green : Colors.grey[600],
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void rateProduct(double rating) {
    userRating.value = rating;
    Get.snackbar(
      'Rating Submitted',
      'Thank you for rating this product!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void shareProduct() {
    final productName = product['name'] ?? 'Amazing Product';
    final productPrice = product['price'] ?? 0.0;
    Share.share(
      'Check out this amazing product: $productName for just \$${productPrice.toStringAsFixed(2)}! Get it now on Mini Store!',
      subject: 'Check out this product on Mini Store',
    );
  }

  void addToCart() {
    isLoading.value = true;

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;

      Get.snackbar(
        'Added to Cart',
        '${quantity.value} ${quantity.value > 1 ? 'items' : 'item'} added to your cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        mainButton: TextButton(
          onPressed: () => Get.toNamed('/cart'),
          child: const Text(
            'VIEW CART',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }

  void buyNow() {
    // Navigate to checkout with current product
    final cartItem = {...product, 'quantity': quantity.value};

    Get.toNamed('/checkout', arguments: [cartItem]);
  }

  void toggleShowAllReviews() {
    showAllReviews.value = !showAllReviews.value;
  }

  void showWriteReview() {
    isWritingReview.value = true;
    userReviewRating.value =
        userRating.value; // Use existing rating if available
  }

  void hideWriteReview() {
    isWritingReview.value = false;
    userReviewText.value = '';
    userReviewRating.value = 0.0;
  }

  void updateReviewRating(double rating) {
    userReviewRating.value = rating;
  }

  void updateReviewText(String text) {
    userReviewText.value = text;
  }

  void submitReview() {
    if (userReviewRating.value == 0.0) {
      Get.snackbar(
        'Rating Required',
        'Please provide a rating before submitting your review',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    if (userReviewText.value.trim().isEmpty) {
      Get.snackbar(
        'Review Required',
        'Please write a review before submitting',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    // Create new review
    final newReview = {
      'user': 'You', // In a real app, this would come from user authentication
      'rating': userReviewRating.value,
      'comment': userReviewText.value.trim(),
      'date': 'Just now',
      'avatar': 'Y',
      'isCurrentUser': true,
    };

    // Add to the beginning of reviews list
    reviews.insert(0, newReview);

    // Update product rating and review count
    final currentRating = product['rating'] ?? 0.0;
    final currentReviewCount = product['reviews'] ?? 0;
    final newReviewCount = currentReviewCount + 1;
    final newAverageRating =
        ((currentRating * currentReviewCount) + userReviewRating.value) /
        newReviewCount;

    product.assignAll({
      ...product,
      'rating': double.parse(newAverageRating.toStringAsFixed(1)),
      'reviews': newReviewCount,
    });

    // Update user's rating
    userRating.value = userReviewRating.value;

    // Hide review form
    hideWriteReview();

    Get.snackbar(
      'Review Submitted',
      'Thank you for your review! It has been added successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  double get totalPrice => (product['price'] ?? 0.0) * quantity.value;

  bool get hasDiscount => (product['discount'] ?? 0) > 0;

  String get discountText => hasDiscount ? '${product['discount']}% OFF' : '';

  List<Map<String, dynamic>> get displayedReviews {
    if (showAllReviews.value) {
      return reviews;
    }
    return reviews.take(2).toList();
  }
}
