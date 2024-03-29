import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class Placeloc {
  const Placeloc({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({required this.title, required this.image, required this.placelocation,id})
      :id= id ?? uuid.v4();
  final String id;
  final String title;
  final File image;
  final Placeloc placelocation;
}
