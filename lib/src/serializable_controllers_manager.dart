import 'controllers/serializable_controller.dart';

class SerializableControllersManager {
  final Map<String, SerializableController?> _controllers = {};

  /// Return a list of the currently stored controllers
  List<SerializableController> get controllers =>
      List<SerializableController>.from(_controllers.values);

  /// Get the controller corresponding to the specified [id]
  SerializableController? getFromId(String id) => _controllers[id];

  ///Creates a `SerializableController` using the provided `createFunction`.
  ///If a controller with the same id already exists and [overwrite] is `false`, return that instead of creating a new one.
  ///Set [overwrite] to `true` to force the creation of a new controller
  C makeController<C extends SerializableController<T>, T>(
      C Function() createFunction,
      {bool overwrite = false}) {
    final controller = createFunction();
    if (overwrite) {
      removeController(controller.id);
    }

    _controllers.putIfAbsent(controller.id, () => controller);

    final result = getFromId(controller.id)!;
    return result as C;
  }

  ///Removes the controller corresponding to the specified [id]
  void removeController(String id) {
    final controller = _controllers[id];
    if (controller != null) {
      _controllers.remove(controller.id);
      controller.dispose();
    }
  }

  ///Serialize controllers values
  Map<String, dynamic> toJson() => {
        for (final controller in _controllers.values)
          if (controller != null) controller.id: controller.value
      };

  ///Dispose all the stored controllers
  void dispose() {
    for (final controller in _controllers.values) {
      controller?.dispose();
    }
  }
}
