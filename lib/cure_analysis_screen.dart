import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CureAnalysisScreen extends StatefulWidget {
  const CureAnalysisScreen({Key? key}) : super(key: key);

  @override
  State<CureAnalysisScreen> createState() => _CureAnalysisScreenState();
}

class _CureAnalysisScreenState extends State<CureAnalysisScreen> {
  File? _selectedImage;
  bool _isProcessing = false;
  String _apiResponse = '';

  _selectImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _sendApiRequest() async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.40.1:8080/upload'));
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      _selectedImage!.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _apiResponse = responseData.toString();
      });
    } else {
      setState(() {
        _apiResponse = 'Error uploading image: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 214, 67),
        title: Text(
          'Cure Analysis',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectImage(ImageSource.gallery),
              child: Text(
                'Select from Gallery',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectImage(ImageSource.camera),
              child: Text(
                'Take from Camera',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_selectedImage != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Image.file(
                  _selectedImage!,
                  width: 200,
                  height: 200,
                ),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _sendApiRequest,
                child: _isProcessing
                    ? const CircularProgressIndicator()
                    : Text(
                        'Process Image',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                        Text(
                          'Analysis Result:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _apiResponse,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
