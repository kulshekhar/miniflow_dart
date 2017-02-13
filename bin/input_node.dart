import 'node.dart';

class Input<T> extends Node {
  @override
  T get value => nodeValue;

  @override
  forward([value]) {
    this.value = value ?? this.value;
  }
}
