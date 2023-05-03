import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  double? _numberForm;
  String _resultMessage = "";

  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from]!;
    int nTo = _measuresMap[to]!;

    var multiplier = _formulas[nFrom.toString()]![nTo];
    var result = value * multiplier;

    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
          '${_numberForm.toString()} $_current_measure are ${result.toString()} $_converted_measure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  void initState() {
    _numberForm = 0;
    super.initState();
  }

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];
  String? _current_measure;
  String? _converted_measure;

  _MyAppState() {
    _current_measure = _measures[0];
    _converted_measure = _measures[1];
  }

  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measure converter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Measures Converter'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Value",
                style: labelStyle,
              ),
              const Spacer(),
              TextField(
                decoration: const InputDecoration(
                    hintText: "Please insert the measure to be converted."),
                onChanged: (text) {
                  var changedText = double.tryParse(text);

                  if (changedText != null) {
                    setState(() {
                      _numberForm = changedText;
                    });
                  }
                },
              ),
              const Spacer(),
              Text(
                "From",
                style: labelStyle,
              ),
              const Spacer(),
              DropdownButton<String>(
                  isExpanded: true,
                  value: _current_measure,
                  items: _measures
                      .map((e) => (DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          )))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _current_measure = newValue;
                    });
                  }),
              const Spacer(),
              Text(
                'To',
                style: labelStyle,
              ),
              const Spacer(),
              DropdownButton<String>(
                  isExpanded: true,
                  value: _converted_measure,
                  items: _measures
                      .map((e) => (DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          )))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _converted_measure = newValue;
                    });
                  }),
              const Spacer(flex: 2),
              ElevatedButton(
                  onPressed: () {
                    if (_numberForm == null ||
                        _current_measure == null ||
                        _converted_measure == null) {
                      return;
                    }
                    convert(
                        _numberForm!, _current_measure!, _converted_measure!);
                  },
                  child: Text(
                    'Convert',
                    style: inputStyle,
                  )),
              const Spacer(flex: 2),
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(_resultMessage, style: labelStyle)),
              const Spacer(
                flex: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
