import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/providers/location_provider.dart';

class MapTrack extends StatefulWidget {
  @override
  _MapTrackState createState() => _MapTrackState();
}

class _MapTrackState extends State<MapTrack> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocationProvider _location=Provider.of<LocationProvider>(context,listen:false);
    _location.initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Live Tracking"),
        backgroundColor: Colors.redAccent,
      ),
      body: googleMapUI(),
    );
  }

  Widget googleMapUI() {
    return Consumer<LocationProvider>(
      builder: (context, model, child) {
        // ignore: unnecessary_null_comparison
        if (model.locationPosition != null) {
          return Column(
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: model.locationPosition,
                    zoom: 18,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: Set<Marker>.of(model.markers!.values),
                  onMapCreated: (GoogleMapController controller) {},
                ),
              ),
            ],
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
