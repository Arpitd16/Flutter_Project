import 'package:favouriteplace/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({
    super.key,
    this.location = const Placeloc(
      latitude: 37.22,
      longitude: -122.04,
      address: '',
    ),
    this.isSelecting = true,
  });
  final bool isSelecting;

  final Placeloc location;
  @override
  State<Mapscreen> createState() {
    return _MapscreenState();
  }
}

class _MapscreenState extends State<Mapscreen> {
  LatLng? _pickedlocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'pick your location' : 'your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_pickedlocation);
              },
            )
        ],
      ),
      body: GoogleMap(
        onTap:widget.isSelecting ? null : (location) {
          setState(() {
            _pickedlocation = location;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (_pickedlocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedlocation ??
                      LatLng(
                        //?? is special flutter operator for the value does not contain null in contain that return after code
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
