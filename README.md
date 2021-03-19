# serializable_controllers

A simple package to lift some of the boilerplate about values handling when dealing with forms.

## Overview
Create controllers through the `SerializableControllersManager` class using the `makeController` method and assign them to the widgets you need on your form.
Each controller implements `ValueNotifier` so it can easily be used to listen changes.

You can get a serialization of the values any time via the `toJson` method of `SerializableControllersManager`.

Remember to use `dispose` on the manager when you're finished to avoid memory leaks!

## Provided controllers

### SerializableTextEditingController
Provides an abstraction for `TextEditingController`.
The inner `TextEditingController` is available via the `controller` property of the object.

Example:
```dart
final serializableTextEditingController = manager.makeController(
      () => SerializableTextEditingController(id: 'myId'),
    );

final textEditingController = serializableTextEditingController.controller;
```

Instead of using boring listeners you can directly listen to text changes listening directly to the object:

```dart
ValueListenableBuilder(
    valueListenable: nameController,
    builder: (_, value, __) => Text(value ?? ''),
),
```

### SerializableChangeController
Provides way to easily update a value through a widget's `ValueChanged` callback.

Example:

```dart
final checkboxController = manager.makeController(
      () => SerializableChangeController(
        id: 'radio',
        initialValue: false,
      ),
    );
```

And use it like this: 

```dart
//in the build method
ValueListenableBuilder(
    valueListenable: checkboxController,
    builder: (context, value, _) =>
        CheckboxListTile(
        value: value,
        onChanged: checkboxController.valueChanged,
        title: Text('Boolean check'),
        )
),
```

As you can see you can easily update the UI without too much hassle too.

### Custom controllers
You can create your own controllers just by extending `SerializableController<T>`!

## Printing the values

Given 
```dart
final manager = SerializableControllersManager();
```

Just call 
```dart
print(jsonEncode(manager.toJson()));
```

Check out the example for more!