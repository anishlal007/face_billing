import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;

class ImagePickerField extends StatefulWidget {
  final String title;
  final Function(dynamic) onImageSelected;

  const ImagePickerField({
    super.key,
    required this.title,
    required this.onImageSelected,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  dynamic _selectedImage; // File (mobile/desktop) or XFile/Web path
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedFile != null) {
      setState(() {
        if (kIsWeb) {
          _selectedImage = pickedFile; // use XFile for web
        } else {
          _selectedImage = File(pickedFile.path); // File for mobile/desktop
        }
      });
      widget.onImageSelected(_selectedImage);
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    if (_selectedImage == null) {
      return const Text("No image selected",
          style: TextStyle(color: Colors.grey));
    }

    if (kIsWeb) {
      // ✅ For web, use Image.network with XFile.path (blob url)
      return Image.network(
        _selectedImage.path,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    } else {
      // ✅ For mobile/desktop, use File
      return Image.file(
        _selectedImage,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: const Icon(Icons.add_a_photo, color: Colors.white),
          label:
              Text(widget.title, style: const TextStyle(color: Colors.white)),
          onPressed: _showPickerOptions,
        ),
        const SizedBox(width: 12),
        _buildPreview(),
      ],
    );
  }
}
