import 'package:flutter/widgets.dart';

import 'serializable_controller.dart';

class SerializableTextEditingController extends SerializableController<String> {
  @override
  final String id;
  final TextEditingController _controller;

  ///Return the associated `TextEditingController`
  TextEditingController get controller => _controller;

  @override
  String get value => _controller.text;

  @override
  set value(String newValue) {
    _controller.text;
  }

  @override
  void update(String value) {
    this.value = value;
    notifyListeners();
  }

  @override
  void addListener(void Function() listener) =>
      _controller.addListener(listener);

  @override
  void removeListener(void Function() listener) =>
      _controller.removeListener(listener);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  SerializableTextEditingController({
    required this.id,
    String? initialValue,
  })  : _controller = TextEditingController(
          text: initialValue,
        ),
        super(initialValue);
}
