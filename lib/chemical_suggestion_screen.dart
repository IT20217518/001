import 'package:flutter/material.dart';

class ChemicalSuggestionScreen extends StatefulWidget {
  const ChemicalSuggestionScreen({Key? key}) : super(key: key);

  @override
  _ChemicalSuggestionScreenState createState() =>
      _ChemicalSuggestionScreenState();
}

class _ChemicalSuggestionScreenState extends State<ChemicalSuggestionScreen> {
  TextEditingController nitrogenController = TextEditingController();
  TextEditingController potassiumController = TextEditingController();
  TextEditingController phosphorusController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController phController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 214, 21),
        title: Text(
          'Chemical Suggestions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text('Nitrogen'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: nitrogenController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter nitrogen',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Potassium'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: potassiumController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter potassium',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Phosphorus'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: phosphorusController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter phosphorus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Humidity'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: humidityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter humidity',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Text('Temperature'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: temperatureController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter temperature',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('PH'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: phController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter ph',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  // Get user input from the text fields
                  String nitrogen = nitrogenController.text;
                  String potassium = potassiumController.text;
                  String phosphorus = phosphorusController.text;
                  String humidity = humidityController.text;
                  String temperature = temperatureController.text;
                  String ph = phController.text;

                  // Perform further processing or chemical suggestion based on the input values
                  // You can access these values and provide chemical suggestions here
                  // You can access the input values as strings and convert them to appropriate data types for calculations
                },
                child: Text(
                  'Recommendation',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
