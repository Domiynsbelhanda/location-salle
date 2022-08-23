import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapHotels extends StatefulWidget {
  @override
  State<MapHotels> createState() => _MapHotels();
}

class _MapHotels extends State<MapHotels> {
  late String _mapStyle;
  late GoogleMapController _mapController;
  final Set<Marker> markers = new Set();

  _onMapCreated(GoogleMapController controller) {
    if (mounted)
      setState(() {
        _mapController = controller;
        controller.setMapStyle(_mapStyle);
      });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  initState() {
    super.initState();
    rootBundle.loadString('assets/text/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}