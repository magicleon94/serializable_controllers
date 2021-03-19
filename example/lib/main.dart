import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serializable_controllers/serializable_controllers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final manager = SerializableControllersManager();

  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = manager.makeController(
      () => SerializableTextEditingController(id: 'nome'),
    );
    final surnameController = manager.makeController(
      () => SerializableTextEditingController(id: 'cognome'),
    );
    final checkboxController = manager.makeController(
      () => SerializableChangeController(
        id: 'radio',
        initialValue: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Serializable controllers'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController.controller,
          ),
          ValueListenableBuilder(
            valueListenable: nameController,
            builder: (_, value, __) => Text(value ?? ''),
          ),
          TextFormField(
            controller: surnameController.controller,
          ),
          ValueListenableBuilder(
            valueListenable: checkboxController,
            builder: (context, value, _) {
              print(value);
              return CheckboxListTile(
                value: value,
                onChanged: checkboxController.valueChanged,
                title: Text('Boolean check'),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              print(jsonEncode(manager.toJson()));
            },
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}
