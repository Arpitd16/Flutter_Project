import 'package:favouriteplace/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';

Future<Database> _getdata() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbpath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE userplaces(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, long REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class Userplaceprovider extends StateNotifier<List<Place>> {
  Userplaceprovider() : super(const []);

  Future<void> loadplace() async {
    final db = await _getdata();
    final datalist = await db.query('userplaces');
    final places = datalist
        .map(
          (row) => Place(
            title: row['title'] as String,
            image: File(row['image'] as String),
            placelocation: Placeloc(
                latitude: row['lat'] as double,
                longitude: row['long'] as double,
                address: row['address'] as String),
          ),
        )
        .toList();
    state = places;
  }

  void addplace(String title, File image, Placeloc placelocation) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copyimg = await image.copy('${appDir.path}/$filename');
    final newplace =
        Place(title: title, image: copyimg, placelocation: placelocation);

    final db = await _getdata();
    db.insert('userplaces', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path,
      'lat': newplace.placelocation.latitude,
      'long': newplace.placelocation.longitude,
      'address': newplace.placelocation.address,
    });
    state = [newplace, ...state];
  }
}

final userplaceprovider = StateNotifierProvider<Userplaceprovider, List<Place>>(
  (ref) => Userplaceprovider(),
);
