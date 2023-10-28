import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({Key? key}) : super(key: key);

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? _selectedImage;
  bool _isProcessing = false;
  Map<String, dynamic> _apiResponse = {};

  _selectImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _sendApiRequest() async {
    if (_selectedImage == null || _isProcessing) {
      // Don't send a new request if an image is being processed or no image is selected.
      return;
    }

    setState(() {
      _isProcessing = true; // Start processing
      _apiResponse = {}; // Clear previous response
    });

    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.40.1:8080/upload'));

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _selectedImage!.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        setState(() {
          _apiResponse = json.decode(response.body);
        });
      } else {
        setState(() {
          _apiResponse = {
            'error': 'Error uploading image: ${response.statusCode}'
          };
        });
      }
    } catch (e) {
      setState(() {
        _apiResponse = {'error': 'Error: $e'};
      });
    } finally {
      setState(() {
        _isProcessing = false; // Finish processing
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 214, 67),
          title: const Text(
            'Disease identification',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          margin: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => _selectImage(ImageSource.gallery),
                  child: const Text('Select from Gallery'),
                ),
                ElevatedButton(
                  onPressed: () => _selectImage(ImageSource.camera),
                  child: const Text('Take from Camera'),
                ),
                if (_selectedImage != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.file(_selectedImage!),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : _sendApiRequest,
                    child: !_isProcessing
                        ? const Text('Process Image')
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
                if (_apiResponse.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Detected Disease:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text(
                                'Result - ${_apiResponse['result'].toString().toUpperCase()}',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
