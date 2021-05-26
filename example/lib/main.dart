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
  SerializableTextEditingController nameController;
  SerializableTextEditingController surnameController;
  SerializableChangeController checkboxController;

  @override
  void initState() {
    nameController = manager.makeController(
      () =>
          SerializableTextEditingController(id: 'nome', initialValue: 'Pippo'),
    );

    surnameController = manager.makeController(
      () => SerializableTextEditingController(id: 'cognome'),
    );

    checkboxController = manager.makeController(
      () => SerializableChangeController(
        id: 'radio',
        initialValue: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            builder: (context, value, _) => CheckboxListTile(
              value: value,
              onChanged: checkboxController.valueChanged,
              title: Text('Boolean check'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final encoder = JsonEncoder.withIndent(' ');
              final encoded = encoder.convert(manager);
              return showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text(encoded),
                ),
              );
            },
            child: Text('Submit'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: manager.resetControllers,
        child: Icon(Icons.restore),
      ),
    );
  }
}
