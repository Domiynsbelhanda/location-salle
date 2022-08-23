import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_event/services/datas.dart';
import 'package:place_event/utils/constant.dart';
import 'package:provider/provider.dart';

import '../models/rooms.dart';


class MapHotels extends StatefulWidget {
  MapHotels({this.rooms});
  final List<Rooms>? rooms;
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

    try{
      print('taillification paille ${widget.rooms!.length}');
    } catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Datas>(
        builder: (context, datas, child){
          try {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: _onMapCreated,
              markers: markers,
            );
          } catch(e){
            return SizedBox();
          }
        }),
    );
  }
}