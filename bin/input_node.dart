import 'node.dart';

class Input extends Node {
  @override
  forward([value]) {
    this.value = value ?? this.value;
  }
}
