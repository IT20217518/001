import 'package:flutter/material.dart';

import 'chemical_suggestion_screen.dart'; // Import your new screen
import 'cure_analysis_screen.dart';
import 'disease_detection_screen.dart';
import 'root_cause_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 214, 57),
          title: const Text(
            'Leafguard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          children: [
            GridItem(
              text: 'Disease Identification',
              color: Colors.blue,
            ),
            GridItem(
              text: 'Root Cause',
              color: Colors.green,
            ),
            GridItem(
              text: 'Chemical Suggestion',
              color: Colors.orange,
            ),
            GridItem(
              text: 'Cure Analysis',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String text;
  final Color color;

  const GridItem({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == 'Disease Identification') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DiseaseDetectionScreen(),
            ),
          );
        } else if (text == 'Root Cause') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RootCauseScreen(),
            ),
          );
        } else if (text == 'Chemical Suggestion') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChemicalSuggestionScreen(),
            ),
          );
        } else if (text == 'Cure Analysis') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CureAnalysisScreen(),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
