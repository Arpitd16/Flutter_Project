import 'dart:io';
import 'package:favouriteplace/models/place.dart';
import 'package:favouriteplace/providers/userplace.dart';
import 'package:favouriteplace/widget/imageinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favouriteplace/widget/locationinput.dart';

class Addplaces extends ConsumerStatefulWidget {
  const Addplaces({super.key});

  @override
  ConsumerState<Addplaces> createState() => _AddplacesState();
}

class _AddplacesState extends ConsumerState<Addplaces> {
  final _titlecontroller = TextEditingController();
  File? _selectedimage;
  Placeloc? _selectedlocation;

  void _saveplace() {
    final enteredtext = _titlecontroller.text;
    if (enteredtext.isEmpty|| _selectedimage == null || _selectedlocation == null) {
      return;
    }
    ref.read(userplaceprovider.notifier).addplace(enteredtext, _selectedimage!, _selectedlocation!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titlecontroller,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 10),
            Imageinput(
              onPickImage: (image) {
                _selectedimage = image;
              },
            ),
            const SizedBox(
              height: 10,
            ),
             Locationinput(
             onselectplace: (loc){
                _selectedlocation = loc;
              
             },   
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: _saveplace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
