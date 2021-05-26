import 'serializable_controller.dart';

class SerializableChangeController<T> extends SerializableController<T> {
  @override
  final String id;

  @override
  void update(T? value) {
    this.value = value;
    notifyListeners();
  }

  ///Use this to pass it as a callback to widgets that notify their value change through callbacks
  void Function(T) get valueChanged => update;

  SerializableChangeController({
    required this.id,
    T? initialValue,
  }) : super(initialValue);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SerializableChangeController && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
