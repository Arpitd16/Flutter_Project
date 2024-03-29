import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imageinput extends StatefulWidget {
  const Imageinput({super.key,required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<Imageinput> createState() {
    return _Imageinput();
  }
}

class _Imageinput extends State<Imageinput> {
  File? _selectedimg;

  void _takepicture() async {
    final _imagepick = ImagePicker();
    final pickedimg =
        await _imagepick.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedimg == null) {
      return;
    }

    setState(() {
      _selectedimg = File(pickedimg.path);
    });
    widget.onPickImage(_selectedimg!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takepicture,
      icon: const Icon(Icons.camera),
      label: const Text('Take picture!'),
    );

    if (_selectedimg != null) {
      content = Image.file(
        _selectedimg!,
        fit: BoxFit.cover,
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
