# Location Picker Feature

This feature replaces the geolocator-based location selection with an interactive map-based location picker using `flutter_map`.

## Features

- **Interactive Map**: Users can tap anywhere on the map to select their delivery location
- **Current Location**: Option to use current device location (requires location permissions)
- **Visual Feedback**: Clear marker showing the selected location
- **Beautiful UI**: Consistent with the app's design language
- **Permission Handling**: Proper handling of location permissions on both Android and iOS

## Dependencies Added

```yaml
flutter_map: ^7.0.2
latlong2: ^0.9.0
permission_handler: ^11.3.1
```

## How It Works

1. **Location Selection**: Users tap on the delivery address section in checkout
2. **Map View**: A full-screen map opens with OpenStreetMap tiles
3. **Location Picking**: Users can:
   - Tap anywhere on the map to select a location
   - Use the "Current" button to set their current location
   - See coordinates displayed below the map
4. **Confirmation**: Users confirm their selection and return to checkout

## Permissions Required

### Android
- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`

### iOS
- `NSLocationWhenInUseUsageDescription`
- `NSLocationAlwaysAndWhenInUseUsageDescription`

## Files Modified

- `lib/app/modules/checkout/views/checkout_view.dart` - Updated UI text
- `lib/app/modules/checkout/controllers/checkout_controller.dart` - Integrated location picker
- `lib/app/modules/checkout/views/location_picker_view.dart` - New location picker widget
- `android/app/src/main/AndroidManifest.xml` - Added location permissions
- `ios/Runner/Info.plist` - Added location usage descriptions
- `pubspec.yaml` - Added new dependencies

## Usage

```dart
// In the checkout controller
Future<void> pickCurrentLocation() async {
  Get.to(() => LocationPickerView(
    initialLatitude: 9.0820, // Default coordinates
    initialLongitude: 38.7636,
    onLocationSelected: (lat, lng) {
      latitude.value = lat;
      longitude.value = lng;
      hasPickedLocation.value = true;
    },
  ));
}
```

## Benefits Over Geolocator

1. **User Choice**: Users can select any location, not just their current one
2. **Visual Interface**: Map-based selection is more intuitive
3. **Flexibility**: Supports both manual selection and current location
4. **Better UX**: Clear visual feedback and confirmation process
5. **Offline Support**: OpenStreetMap tiles work without internet (if cached)

## Future Enhancements

- Add address reverse geocoding to show actual addresses
- Implement location search functionality
- Add favorite/saved locations
- Support for multiple delivery addresses
- Integration with delivery cost calculation based on distance
