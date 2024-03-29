import 'package:favouriteplace/screen/maps.dart';
import 'package:flutter/material.dart';
import 'package:favouriteplace/models/place.dart';

class Placedetail extends StatelessWidget {
  const Placedetail({super.key, required this.place});

  final Place place;

  String get locationimage {
    final lat = place.placelocation.latitude;
    final long = place.placelocation.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$long&key=YOUR_API_KEY'; //replace with apikey
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                GestureDetector(onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Mapscreen(
                        location: place.placelocation,
                        isSelecting: false,
                      ),
                    ),
                  );
                }),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(locationimage),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: Text(
                    place.placelocation.address,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
