// location_service.dart

import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;

class LocationService {
  final loc.Location _location = loc.Location();

  Future<loc.LocationData> getLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        throw Exception('Location permission denied.');
      }
    }

    return await _location.getLocation();
  }

  Future<List<geo.Placemark>> getPlacemark(loc.LocationData locationData) async {
    return await geo.placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
  }
}
