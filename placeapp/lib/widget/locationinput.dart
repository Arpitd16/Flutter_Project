import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:favouriteplace/models/place.dart';
import 'package:favouriteplace/screen/maps.dart';

class Locationinput extends StatefulWidget {
  const Locationinput({
    super.key,
    required this.onselectplace,
  });

  final void Function(Placeloc location) onselectplace;

  @override
  State<Locationinput> createState() {
    return _Locationinputstate();
  }
}

class _Locationinputstate extends State<Locationinput> {
  Placeloc? _picklocation;
  var _isgettinglocation = false;

  String get locationimage {
    if (_picklocation == null) {
      return '';
    }
    final lat = _picklocation!.latitude;
    final long = _picklocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$long&key=YOUR_API_KEY&signature=YOUR_SIGNATURE';
  }

  Future<void> _saveplace(double lattiude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lattiude,$longitude&key=/YOUR_API_KEY');
    final response = await http.get(url);
    final resdata = json.decode(response.body);
    final address = resdata['results'][0]['formatted_address'];

    setState(() {
      _picklocation = Placeloc(
        latitude: lattiude,
        longitude: longitude,
        address: address,
      );
      _isgettinglocation = false;
    });
    widget.onselectplace(_picklocation!);
  }

  void _currentloc() async {
    Location location =
        Location(); // live location function taken from location pub dev

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isgettinglocation = true;
    });

    locationData = await location.getLocation();
    var lat = locationData.latitude;
    var long = locationData.longitude;

    if (lat == null || long == null) {
      return;
    }

    _saveplace(lat, long);
  }

  void _selectedon() async {
    final pickedlocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => Mapscreen(),
      ),
    );
    if (pickedlocation == null) {
      return;
    }
    _saveplace(pickedlocation.latitude, pickedlocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewcontent = Text(
      'No image selected',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (_picklocation != null) {
      previewcontent = Image.network(
        locationimage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (_isgettinglocation) {
      previewcontent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          height: 170,
          width: double.infinity,
          child: previewcontent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _currentloc,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
