import 'package:flutter/foundation.dart';

abstract class SerializableController<T> extends ValueNotifier<T> {
  SerializableController(value) : super(value);

  ///The [id] of the controlelr
  String get id;

  ///The [value] of the controller
  T get value;

  ///Update function for the controller
  void update(T value);

  ///Add a listener to the controller
  void addListener(void Function() listener);

  ///Remove a listener from the controller
  void removeListener(void Function() listener);

  ///Dispose the controller
  void dispose();

  ///Serialize the controller to json
  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}
