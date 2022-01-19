import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  //TODO initialize constructor
  LocationProvider() {
    _location = Location();
  }
  BitmapDescriptor? _pinLocationIcon;
  BitmapDescriptor? get pinLocationIcon => _pinLocationIcon;
  Map<MarkerId, Marker>? _markers;
  Map<MarkerId, Marker>? get markers => _markers;

  final MarkerId markerId = MarkerId("1");

  late Location _location;
  Location get location => _location;
  late LatLng _locationPosition;
  LatLng get locationPosition => _locationPosition;

  bool locationServiceActive = true;

  initialization() async {
    await getUserLocation();
    await setCustomMapPin();
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.onLocationChanged.listen((LocationData currentLocation) {
      _locationPosition = LatLng(currentLocation.latitude ?? 340.0,
          currentLocation.longitude ?? 250.0);
      print(_locationPosition);

      _markers = <MarkerId, Marker>{};
      Marker marker = Marker(
          markerId: markerId,
          position: LatLng(currentLocation.latitude ?? 340.0,
              currentLocation.longitude ?? 250.0),
          draggable: true,
          icon: pinLocationIcon!,
          onDragEnd: ((newPosition) {
            _locationPosition =
                LatLng(newPosition.latitude, newPosition.longitude);
            notifyListeners();
          }));
      _markers![markerId] = marker;
      notifyListeners();
    });
  }

  setCustomMapPin() async {
    _pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/marker.png');
  }
}
