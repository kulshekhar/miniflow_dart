import 'node.dart';

class InputNode<T> extends Node {
  @override
  T get value => nodeValue;

  @override
  forward([value]) {
    this.value = value ?? this.value;
  }
}

InputNode<T> Input<T>() => new InputNode<T>();
