import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class LocationPickerView extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;
  final Function(double, double, String) onLocationSelected;

  const LocationPickerView({
    super.key,
    required this.initialLatitude,
    required this.initialLongitude,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerView> createState() => _LocationPickerViewState();
}

class _LocationPickerViewState extends State<LocationPickerView> {
  late MapController _mapController;
  late LatLng _selectedLocation;
  bool _isLoading = true;
  String _placeName = "Loading...";
  bool _isLoadingPlaceName = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _selectedLocation = LatLng(widget.initialLatitude, widget.initialLongitude);
    _requestLocationPermission();

    // Get initial place name
    _getPlaceName(widget.initialLatitude, widget.initialLongitude);
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        "Permission Required",
        "Location permission is needed to show your current location",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    setState(() {
      _selectedLocation = point;
      _placeName = "Loading...";
    });

    // Get place name for the new location
    _getPlaceName(point.latitude, point.longitude);
  }

  Future<void> _getPlaceName(double latitude, double longitude) async {
    try {
      setState(() {
        _isLoadingPlaceName = true;
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String placeName = "";

        // Build a readable address
        if (place.street != null && place.street!.isNotEmpty) {
          placeName += place.street!;
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          if (placeName.isNotEmpty) placeName += ", ";
          placeName += place.subLocality!;
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          if (placeName.isNotEmpty) placeName += ", ";
          placeName += place.locality!;
        }
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty) {
          if (placeName.isNotEmpty) placeName += ", ";
          placeName += place.administrativeArea!;
        }
        if (place.country != null && place.country!.isNotEmpty) {
          if (placeName.isNotEmpty) placeName += ", ";
          placeName += place.country!;
        }

        // If we couldn't build a readable address, use coordinates as fallback
        if (placeName.isEmpty) {
          placeName =
              "Lat: ${latitude.toStringAsFixed(4)}, Lng: ${longitude.toStringAsFixed(4)}";
        }

        setState(() {
          _placeName = placeName;
        });
      } else {
        setState(() {
          _placeName =
              "Lat: ${latitude.toStringAsFixed(4)}, Lng: ${longitude.toStringAsFixed(4)}";
        });
      }
    } catch (e) {
      print("Error getting place name: $e");
      setState(() {
        _placeName =
            "Lat: ${latitude.toStringAsFixed(4)}, Lng: ${longitude.toStringAsFixed(4)}";
      });
    } finally {
      setState(() {
        _isLoadingPlaceName = false;
      });
    }
  }

  void _confirmLocation() {
    print("Confirm location called"); // Debug print
    try {
      // Call the callback first
      print("Calling onLocationSelected callback"); // Debug print
      widget.onLocationSelected(
        _selectedLocation.latitude,
        _selectedLocation.longitude,
        _placeName,
      );

      print("Callback completed, showing success message"); // Debug print
      // Show success message

      Navigator.of(context).pop();
      print("Navigator.pop() called"); // Debug print
    } catch (e) {
      print("Error in _confirmLocation: $e"); // Debug print
      // If there's an error, still try to close the map
      Get.back();

      // Show error message
      Get.snackbar(
        "Error",
        "Failed to save location: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _useCurrentLocation() async {
    try {
      // Check if location permission is granted
      final status = await Permission.location.status;
      if (!status.isGranted) {
        final result = await Permission.location.request();
        if (!result.isGranted) {
          Get.snackbar(
            "Permission Required",
            "Location permission is needed to get your current location",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          return;
        }
      }

      // For now, we'll use the initial coordinates as "current location"
      // In a real app, you'd use geolocator or another package to get actual current location
      setState(() {
        _selectedLocation = LatLng(
          widget.initialLatitude,
          widget.initialLongitude,
        );
      });

      _mapController.move(_selectedLocation, 15.0);

      // Get place name for current location
      _getPlaceName(widget.initialLatitude, widget.initialLongitude);

      Get.snackbar(
        "Success",
        "Current location set",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to get current location: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Select Delivery Location',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: _useCurrentLocation,
            icon: const Icon(Icons.my_location, color: Color(0xFF10B981)),
            label: const Text(
              'Current',
              style: TextStyle(color: Color(0xFF10B981)),
            ),
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                ),
              )
              : Column(
                children: [
                  // Map Container
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: _selectedLocation,
                            initialZoom: 15.0,
                            onTap: _onMapTap,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.mini_store',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: _selectedLocation,
                                  width: 40,
                                  height: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF10B981,
                                          ).withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Location Details
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Color(0xFF10B981),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_isLoadingPlaceName)
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  const Color(0xFF10B981),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Loading address...',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      _placeName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1E293B),
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Coordinates: ${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF10B981),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: const Color(
                                0xFF10B981,
                              ).withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _confirmLocation,
                            child: const Text(
                              'Confirm Location',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
