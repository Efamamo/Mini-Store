import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            _buildAppBar(),

            // Step Indicator
            _buildStepIndicator(),

            // Form Content
            Expanded(
              child: Form(
                key: controller.formKey,
                child: Obx(
                  () => IndexedStack(
                    index: controller.currentStep.value,
                    children: [
                      _buildBasicInfoStep(),
                      _buildImagesStep(),
                      _buildPricingStep(),
                      _buildCategoryStockStep(),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    controller.isEditMode.value
                        ? 'Edit Product'
                        : 'Add New Product',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.stepTitles[controller.currentStep.value],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: controller.saveDraft,
            child: const Text(
              'Save Draft',
              style: TextStyle(
                color: Color(0xFFF59E0B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Obx(
        () => Row(
          children: List.generate(
            controller.stepTitles.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () => _goToStepWithValidation(index),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            index <= controller.currentStep.value
                                ? const Color(0xFF3B82F6)
                                : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child:
                            index < controller.currentStep.value
                                ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                )
                                : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color:
                                        index <= controller.currentStep.value
                                            ? Colors.white
                                            : Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.stepTitles[index],
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            index <= controller.currentStep.value
                                ? const Color(0xFF3B82F6)
                                : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Information'),
          const SizedBox(height: 20),

          _buildTextField(
            controller: controller.nameController,
            label: 'Product Name',
            hint: 'Enter product name',
            icon: Icons.inventory,
            validator: controller.validateName,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: controller.brandController,
            label: 'Brand',
            hint: 'Enter brand name',
            icon: Icons.business,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: controller.descriptionController,
            label: 'Description',
            hint: 'Describe your product...',
            icon: Icons.description,
            maxLines: 4,
            validator: controller.validateDescription,
          ),
        ],
      ),
    );
  }

  Widget _buildImagesStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Product Images'),
          const SizedBox(height: 8),
          Text(
            'Add high-quality images to showcase your product',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 20),

          // Add Images Button
          GestureDetector(
            onTap: controller.pickImages,
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 48,
                    color: Color(0xFF3B82F6),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap to add images',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'JPG, PNG up to 5MB',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Selected Images
          Obx(
            () =>
                controller.selectedImages.isNotEmpty
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Images',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1,
                              ),
                          itemCount: controller.selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(controller.selectedImages[index]),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => controller.removeImage(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Pricing'),
          const SizedBox(height: 20),

          _buildTextField(
            controller: controller.priceController,
            label: 'Current Price',
            hint: '0.00',
            icon: Icons.attach_money,
            keyboardType: TextInputType.number,
            validator: controller.validatePrice,
          ),

          const SizedBox(height: 20),

          // Discount Toggle
          Obx(
            () => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer,
                    color:
                        controller.hasDiscount.value
                            ? const Color(0xFF10B981)
                            : Colors.grey[600],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add Discount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          'Set original price to show discount',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: controller.hasDiscount.value,
                    onChanged: (value) => controller.toggleDiscount(),
                    activeColor: const Color(0xFF10B981),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Original Price (if discount enabled)
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: controller.hasDiscount.value ? null : 0,
              child:
                  controller.hasDiscount.value
                      ? Column(
                        children: [
                          _buildTextField(
                            controller: controller.originalPriceController,
                            label: 'Original Price',
                            hint: '0.00',
                            icon: Icons.price_change,
                            keyboardType: TextInputType.number,
                            validator: controller.validateOriginalPrice,
                          ),
                          const SizedBox(height: 12),
                          Obx(
                            () =>
                                controller.discountPercentage != null
                                    ? Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF10B981,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.trending_down,
                                            color: Color(0xFF10B981),
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Discount: ${controller.discountPercentage!.toStringAsFixed(1)}%',
                                            style: const TextStyle(
                                              color: Color(0xFF10B981),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    : const SizedBox.shrink(),
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStockStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Category & Stock'),
          const SizedBox(height: 20),

          // Category Selection
          const Text(
            'Category',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];

              return GestureDetector(
                onTap: () => controller.selectCategory(index),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        controller.selectedCategoryIndex.value == index
                            ? category['color']
                            : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          controller.selectedCategoryIndex.value == index
                              ? category['color']
                              : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category['icon'],
                        color:
                            controller.selectedCategoryIndex.value == index
                                ? Colors.white
                                : category['color'],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          category['name'],
                          style: TextStyle(
                            color:
                                controller.selectedCategoryIndex.value == index
                                    ? Colors.white
                                    : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Stock
          _buildTextField(
            controller: controller.stockController,
            label: 'Stock Quantity',
            hint: 'Enter available quantity',
            icon: Icons.inventory_2,
            keyboardType: TextInputType.number,
            validator: controller.validateStock,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFF3B82F6)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(
          () => Row(
            children: [
              // Previous Button
              if (controller.currentStep.value > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.previousStep,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                    ),
                    child: const Text(
                      'Previous',
                      style: TextStyle(
                        color: Color(0xFF3B82F6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              if (controller.currentStep.value > 0) const SizedBox(width: 16),

              // Next/Save Button
              Expanded(
                flex: controller.currentStep.value == 0 ? 1 : 1,
                child: ElevatedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : () {
                            if (controller.currentStep.value <
                                controller.stepTitles.length - 1) {
                              if (controller.validateCurrentStep()) {
                                controller.nextStep();
                              }
                            } else {
                              controller.saveProduct();
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      controller.isLoading.value
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            controller.currentStep.value <
                                    controller.stepTitles.length - 1
                                ? 'Next'
                                : (controller.isEditMode.value
                                    ? 'Update Product'
                                    : 'Save Product'),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToStepWithValidation(int targetStep) {
    final currentStep = controller.currentStep.value;

    // If trying to go to the same step, do nothing
    if (targetStep == currentStep) return;

    // If trying to go backwards, allow it without validation
    if (targetStep < currentStep) {
      controller.goToStep(targetStep);
      return;
    }

    // If trying to go forwards, validate all steps between current and target
    bool canProceed = true;
    String errorMessage = '';

    for (int step = currentStep; step < targetStep; step++) {
      if (!_validateStep(step)) {
        canProceed = false;
        errorMessage = _getStepErrorMessage(step);
        break;
      }
    }

    if (canProceed) {
      controller.goToStep(targetStep);
    } else {
      Get.snackbar(
        'Validation Required',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  bool _validateStep(int step) {
    switch (step) {
      case 0: // Basic Info
        return controller.validateName(controller.nameController.text) ==
                null &&
            controller.validateDescription(
                  controller.descriptionController.text,
                ) ==
                null;
      case 1: // Images
        return controller.selectedImages.isNotEmpty;
      case 2: // Pricing
        return controller.validatePrice(controller.priceController.text) ==
                null &&
            controller.validateOriginalPrice(
                  controller.originalPriceController.text,
                ) ==
                null;
      case 3: // Category & Stock
        return controller.validateStock(controller.stockController.text) ==
            null;
      default:
        return true;
    }
  }

  String _getStepErrorMessage(int step) {
    switch (step) {
      case 0:
        if (controller.validateName(controller.nameController.text) != null) {
          return 'Please enter a valid product name (at least 3 characters)';
        }
        if (controller.validateDescription(
              controller.descriptionController.text,
            ) !=
            null) {
          return 'Please enter a valid description (at least 10 characters)';
        }
        return 'Please complete the basic information';
      case 1:
        return 'Please add at least one product image';
      case 2:
        if (controller.validatePrice(controller.priceController.text) != null) {
          return 'Please enter a valid price';
        }
        if (controller.validateOriginalPrice(
              controller.originalPriceController.text,
            ) !=
            null) {
          return 'Please enter a valid original price or disable discount';
        }
        return 'Please complete the pricing information';
      case 3:
        return 'Please enter a valid stock quantity';
      default:
        return 'Please complete this step';
    }
  }
}
