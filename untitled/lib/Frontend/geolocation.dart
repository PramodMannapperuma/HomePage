import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/Frontend/app_bar.dart';

class GeoLocation extends StatefulWidget {
  const GeoLocation({super.key, required String token});

  @override
  State<GeoLocation> createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = "";

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print('Srvice desabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'location',
          showActions: true,
          showLeading: true,
          context: context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Location coordinates',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
                'Latitude = ${_currentLocation?.latitude} ; Longitude = ${_currentLocation?.longitude}'),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: 6,
            ),
            Text('${_currentAddress}'),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () async {
                _currentLocation = await _getCurrentLocation();
                await _getAddressFromCoordinates();
                print('${_currentLocation}');
                print('${_currentAddress}');
              },
              child: Text('Get Coordinates'),
            ),
          ],
        ),
      ),
    );
  }
}

