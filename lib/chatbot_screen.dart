import 'package:flutter/material.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uuid/uuid.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<types.Message> _messages = [];

  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();

    // Load initial messages here, if needed
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

//API
  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    // Add the user's message to the chat

    _addMessage(textMessage);

    try {
      final response = await http.post(
        // Uri.parse('http://192.168.182.112:8080/chats'),
        Uri.parse('http://localhost:8000/chats'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'name': message.text}),
      );

      if (response.statusCode == 200) {
        final botMessage = types.TextMessage(
          author: const types.User(id: 'bot'),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: jsonDecode(response.body),
        );

        _addMessage(botMessage);

        // Handle successful response

        // Parse and use the response data
      } else {
        // Handle non-200 HTTP response codes

        print('API Request Failed: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors

      print('Network Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 214, 21),
          title: const Text(
            'Chatbot',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      );
}
