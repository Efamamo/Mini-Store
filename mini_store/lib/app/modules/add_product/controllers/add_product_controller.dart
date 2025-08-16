import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  // Form controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final originalPriceController = TextEditingController();
  final stockController = TextEditingController();
  final brandController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Observable variables
  var selectedCategoryIndex = 0.obs;
  var selectedImages = <String>[].obs;
  var currentStep = 0.obs;
  var isLoading = false.obs;
  var hasDiscount = false.obs;
  var isEditMode = false.obs;

  // Categories
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Electronics',
      'icon': Icons.devices,
      'color': const Color(0xFF3B82F6),
    },
    {
      'name': 'Fashion',
      'icon': Icons.checkroom,
      'color': const Color(0xFFEC4899),
    },
    {
      'name': 'Home & Garden',
      'icon': Icons.home,
      'color': const Color(0xFF10B981),
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_soccer,
      'color': const Color(0xFFF59E0B),
    },
    {'name': 'Beauty', 'icon': Icons.face, 'color': const Color(0xFF8B5CF6)},
    {
      'name': 'Food',
      'icon': Icons.restaurant,
      'color': const Color(0xFFEF4444),
    },
    {'name': 'Books', 'icon': Icons.book, 'color': const Color(0xFF06B6D4)},
    {'name': 'Toys', 'icon': Icons.toys, 'color': const Color(0xFFF97316)},
    {
      'name': 'Automotive',
      'icon': Icons.directions_car,
      'color': const Color(0xFF64748B),
    },
    {'name': 'Pets', 'icon': Icons.pets, 'color': const Color(0xFF84CC16)},
  ];

  // Step titles
  final List<String> stepTitles = [
    'Basic Info',
    'Images',
    'Pricing',
    'Category & Stock',
  ];

  @override
  void onInit() {
    super.onInit();
    _checkEditMode();
  }

  void _checkEditMode() {
    final args = Get.arguments;
    if (args != null && args['mode'] == 'edit' && args['product'] != null) {
      isEditMode.value = true;
      _populateFields(args['product']);
    }
  }

  void _populateFields(Map<String, dynamic> product) {
    nameController.text = product['name'] ?? '';
    descriptionController.text = product['description'] ?? '';
    priceController.text = product['price'].toString();
    originalPriceController.text = product['originalPrice'].toString();
    stockController.text = product['stock'].toString();
    brandController.text = product['brand'] ?? '';

    hasDiscount.value = (product['discount'] ?? 0) > 0;
    selectedImages.value = [product['image']];

    // Find category index
    final categoryName = product['category'];
    final categoryIndex = categories.indexWhere(
      (cat) => cat['name'] == categoryName,
    );
    if (categoryIndex != -1) {
      selectedCategoryIndex.value = categoryIndex;
    }
  }

  void nextStep() {
    if (currentStep.value < stepTitles.length - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    currentStep.value = step;
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void toggleDiscount() {
    hasDiscount.value = !hasDiscount.value;
    if (!hasDiscount.value) {
      originalPriceController.clear();
    }
  }

  Future<void> pickImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage(
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (images.isNotEmpty) {
        for (XFile image in images) {
          selectedImages.add(image.path);
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick images: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name is required';
    }
    if (value.trim().length < 3) {
      return 'Product name must be at least 3 characters';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return 'Please enter a valid price';
    }
    return null;
  }

  String? validateOriginalPrice(String? value) {
    if (!hasDiscount.value) return null;

    if (value == null || value.trim().isEmpty) {
      return 'Original price is required when discount is enabled';
    }
    final originalPrice = double.tryParse(value);
    final currentPrice = double.tryParse(priceController.text);

    if (originalPrice == null || originalPrice <= 0) {
      return 'Please enter a valid original price';
    }
    if (currentPrice != null && originalPrice <= currentPrice) {
      return 'Original price must be higher than current price';
    }
    return null;
  }

  String? validateStock(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Stock quantity is required';
    }
    final stock = int.tryParse(value);
    if (stock == null || stock < 0) {
      return 'Please enter a valid stock quantity';
    }
    return null;
  }

  bool validateCurrentStep() {
    switch (currentStep.value) {
      case 0: // Basic Info
        return formKey.currentState?.validate() ?? false;
      case 1: // Images
        if (selectedImages.isEmpty) {
          Get.snackbar(
            'Images Required',
            'Please add at least one product image',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          return false;
        }
        return true;
      case 2: // Pricing
        return validatePrice(priceController.text) == null &&
            validateOriginalPrice(originalPriceController.text) == null;
      case 3: // Category & Stock
        return validateStock(stockController.text) == null;
      default:
        return true;
    }
  }

  Future<void> saveProduct() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fix all errors before saving',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final product = {
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'price': double.parse(priceController.text),
        'originalPrice':
            hasDiscount.value
                ? double.parse(originalPriceController.text)
                : null,
        'stock': int.parse(stockController.text),
        'brand': brandController.text.trim(),
        'category': categories[selectedCategoryIndex.value]['name'],
        'images': selectedImages.toList(),
        'status': 'active',
        'createdAt': DateTime.now(),
      };

      Get.snackbar(
        isEditMode.value ? 'Product Updated' : 'Product Added',
        isEditMode.value
            ? '${product['name']} has been updated successfully'
            : '${product['name']} has been added to your inventory',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // Navigate back to My Products
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save product: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void saveDraft() {
    Get.snackbar(
      'Draft Saved',
      'Product has been saved as draft',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFF59E0B),
      colorText: Colors.white,
    );
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    originalPriceController.dispose();
    stockController.dispose();
    brandController.dispose();
    super.onClose();
  }

  double? get discountPercentage {
    if (!hasDiscount.value) return null;
    final price = double.tryParse(priceController.text);
    final originalPrice = double.tryParse(originalPriceController.text);
    if (price != null && originalPrice != null && originalPrice > price) {
      return ((originalPrice - price) / originalPrice * 100);
    }
    return null;
  }
}
