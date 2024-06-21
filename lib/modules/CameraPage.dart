import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CameraPage extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  XFile? _imageFile;
  bool _isCameraInitializing = false;
  bool _isCameraOn = false;

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      setState(() {
        _cameras = value;
        _isCameraInitializing = true;
        _openCamera(_cameras![0]);
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _openCamera(CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _controller = cameraController;

    await cameraController.initialize();

    // Ensure flash is off
    await cameraController.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }

    setState(() {
      _isCameraInitializing = false;
      _isCameraOn = true;
    });
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = image;
        _isCameraOn = false;
      });
      // _showInitialDialog(context, _imageFile!.path);
      _processAndUploadImage(_imageFile!.path);
    }
  }

  Future<void> _takePicture() async {
    if (_controller != null && !_isCameraInitializing && _controller!.value.isInitialized) {
      final XFile? image = await _controller?.takePicture();

      if (image != null) {
        setState(() {
          _imageFile = image;
          _isCameraOn = false;
        });

        print('Image path: ${_imageFile!.path}');
        // _showInitialDialog(context, _imageFile!.path);
        _processAndUploadImage(_imageFile!.path);
      }
    }
  }

  Future<void> _processAndUploadImage(String imagePath) async {
    try {
      final result = await _sendImageForProcessing(imagePath);
      _showResultDialog(context, imagePath, result: result);
    } catch (e) {
      print('Error processing image: $e');
    }
  }

  Future<Map<String, dynamic>> _sendImageForProcessing(String imagePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://197.53.146.110:5000/'));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } else {
      throw Exception('Failed to process image');
    }
  }

  // void _showInitialDialog(BuildContext context, String imagePath) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Image Preview'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Image.file(File(imagePath)),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showResultDialog(BuildContext context, String imagePath, {Map<String, dynamic>? result}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(result != null ? '${result['name']}' : 'Processing Result'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(File(imagePath)),
                if (result != null) ...[
                  SizedBox(height: 10),
                  // Text('${result['name']}'),
                  Text('${result['text_english']}'),
                  SizedBox(height: 5),
                  Text('${result['text_arabic']}'),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isCameraInitializing)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            _cameras == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : _controller?.value.isInitialized == true
                ? Positioned.fill(
              child: CameraPreview(_controller!),
            )
                : Container(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(Icons.photo_library_rounded),
                    onPressed: _pickImageFromGallery,
                  ),
                  label: 'Import Image',
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(Icons.camera_alt_rounded),
                    onPressed: _takePicture,
                  ),
                  label: 'Camera',
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(Icons.photo_size_select_actual),
                    onPressed: _imageFile != null
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImagePage(image: _imageFile!)),
                      );
                    }
                        : null,
                  ),
                  label: 'Show Image',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  final XFile image;

  const ImagePage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: Image.file(File(image.path)),
      ),
    );
  }
}
