import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

enum MathOpp { addition, soustraction, division, multiplication }

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  int _step = 2;
  int _totalPushed = 0;

  int _totalResult = 0;

  MathOpp _selectedCalculationType = MathOpp.addition;
  String _signDisplay = "+";

  void _incrementCounter() {
    setState(() {
      if (_selectedCalculationType == MathOpp.addition) {
        _totalResult += _step;
      }
      if (_selectedCalculationType == MathOpp.soustraction) {
        _totalResult -= _step;
      }
      if (_selectedCalculationType == MathOpp.multiplication) {
        _totalResult *= _step;
      }
      if (_selectedCalculationType == MathOpp.division) {
        _totalResult ~/ _step;
      }
      _totalPushed++;
    });
  }

  void _changeSign() {
    setState(() {
      if (_selectedCalculationType == MathOpp.addition) {
        _signDisplay = "+";
      }
      if (_selectedCalculationType == MathOpp.soustraction) {
        _signDisplay = "-";
      }
      if (_selectedCalculationType == MathOpp.multiplication) {
        _signDisplay = "x";
      }
      if (_selectedCalculationType == MathOpp.division) {
        _signDisplay = ":";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<MathOpp>(
              value: _selectedCalculationType,
              onChanged: (MathOpp? newValue) {
                setState(() {
                  _selectedCalculationType = newValue!;
                  _changeSign();
                });
              },
              items: MathOpp.values
                  .map<DropdownMenuItem<MathOpp>>((MathOpp value) {
                return DropdownMenuItem<MathOpp>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
            const Text(
              'Selection du type de calcule :',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200, right: 200),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
                onChanged: (value) => setState(() {
                  try {
                    _step = int.tryParse(value)!;
                  } catch (e) {
                    print(e.toString());
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Alert Value'),
                        content: const Text(
                            'Vous devez rentrer une valeur nuemrique !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    _step = 1;
                  } finally {}
                }),
              ),
            ),
            Text(
              'Vous avez cliqué $_totalPushed fois',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$_counter $_signDisplay $_step = ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '$_totalResult',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Text(
          '$_signDisplay $_step',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
