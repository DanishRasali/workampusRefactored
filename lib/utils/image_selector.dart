// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageCapture extends StatefulWidget {
//   @override
//   _ImageCaptureState createState() => _ImageCaptureState();
// }

// class _ImageCaptureState extends State<ImageCapture> {
//   // active image file
//   PickedFile _imageFile;

//   Future<void> _pickImage(ImageSource source) async {
//     PickedFile selected = await ImagePicker().getImage(source: source);

//     setState(() {
//       _imageFile = selected;
//     });
//   }

//   Future<void> _cropImage() async {
//     File cropped = await ImageCropper.cropImage(
//       sourcePath: _imageFile.path,
//       maxWidth: 1080,
//       maxHeight: 1080,
//     );
//     setState(() {
//       _imageFile = cropped ?? _imageFile;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
