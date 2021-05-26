import 'package:flutter/foundation.dart';

abstract class SerializableController<T> extends ValueNotifier<T?> {
  ///The [initialValue] of the controller
  final T? _initialValue;

  SerializableController(T? initialValue)
      : _initialValue = initialValue,
        super(initialValue);

  ///The [id] of the controlelr
  String get id;

  ///The [value] of the controller
  T? get value;

  ///Update function for the controller
  void update(T? value);

  ///Dispose the controller
  @mustCallSuper
  void dispose() => super.dispose();

  ///Serialize the controller to json
  Map<String, dynamic> toJson() => {'id': id, 'value': value};

  ///Resets the controller to its initial value
  void reset() => update(_initialValue);
}
