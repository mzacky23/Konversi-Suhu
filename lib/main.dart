import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  TextEditingController input = TextEditingController();

  double kelvin = 0;
  double reamur = 0;
  double fahrenheit = 0;

  hitung() {
    setState(() {
      if (formKey.currentState!.validate()) {
        reamur = 4 / 5 * double.parse(input.text);
        kelvin = double.parse(input.text) + 273;
        fahrenheit = (double.parse(input.text) * 9 / 5) + 32;
      }
    });
  }

  void reset() {
    setState(() {
      input.text = "";
      kelvin = 0;
      reamur = 0;
      fahrenheit = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Konverter Suhu",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.ac_unit_rounded,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                  controller: input,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      _messangerKey.currentState!.showSnackBar(
                          const SnackBar(content: Text("Input Number")));
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Inputkan angka",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(25))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Suhu dalam Kelvin"),
                      Text(
                        kelvin.toStringAsFixed(2),
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("Suhu dalam Reamur"),
                      Text(
                        reamur.toStringAsFixed(2),
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("Suhu dalam Fahrenheit"),
                      Text(
                        fahrenheit.toStringAsFixed(2),
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    hitung();
                  }
                },
                child: Text("Hitung"),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  reset();
                },
                child: Text("Reset"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
