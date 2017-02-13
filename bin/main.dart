import 'add_node.dart';
import 'array.dart';
import 'input_node.dart';
import 'linear_node.dart';
import 'mse_node.dart';
import 'mul_node.dart';
import 'sigmoid_node.dart';
import 'util.dart';

main(List<String> args) {
  mse();
  sigmoid();
  linearTransform();
  linear();
  addAndMultiply();
  // array();
}

mse() {
  final y = Input<ArrayClass>();
  final a = Input<ArrayClass>();
  final cost = MSE(y, a);

  final y_ = Array([1, 2, 3]);
  final a_ = Array([4.5, 5, 10]);

  final feedDict = {y: y_, a: a_};
  final graph = topologicalSort(feedDict);
  final output = forwardPass(cost, graph);

  print('MSE: $output');
}

sigmoid() {
  final X = Input<ArrayClass>();
  final W = Input<ArrayClass>();
  final b = Input<ArrayClass>();

  final f = Linear(X, W, b);
  final g = Sigmoid(f);

  final X_ = Array([
    [-1.0, -2.0],
    [-1, -2]
  ]);
  final W_ = Array([
    [2.0, -3],
    [2.0, -3]
  ]);
  final b_ = Array([-3.0, -5]);

  final feedDict = {X: X_, W: W_, b: b_};

  final graph = topologicalSort(feedDict);
  final output = forwardPass(g, graph);

  print('Sigmoid: $output');
}

linearTransform() {
  final X = Input<ArrayClass>();
  final W = Input<ArrayClass>();
  final b = Input<ArrayClass>();

  final f = Linear(X, W, b);

  final X_ = Array([
    [-1.0, -2.0],
    [-1, -2]
  ]);
  final W_ = Array([
    [2.0, -3],
    [2.0, -3]
  ]);
  final b_ = Array([-3.0, -5]);

  final feedDict = {X: X_, W: W_, b: b_};

  final graph = topologicalSort(feedDict);
  final output = forwardPass(f, graph);

  print('Linear Transform: $output');
}

array() {
  var a1 = Array([1, 2, 3]);
  var a2 = Array([
    [1, 2],
    [1, 2],
    [1, 2],
  ]);
  var a3 = Array([
    [1, 2, 3],
    [1, 2, 3],
  ]);

  print('>>>>>>>');
  print(a1.T);
  print(a2.T);
  print(a1 * a1);
  print(a1 * a2);
  print(a3 * a2);
  print('>>>>>>>');
}

linear() {
  var inputs = Input<ArrayClass>();
  var weights = Input<ArrayClass>();
  var bias = Input<ArrayClass>();

  var f = Linear(inputs, weights, bias);
  Map<InputNode, dynamic> feedDict = {
    inputs: Array([6, 14, 3]),
    weights: Array([0.5, 0.25, 1.4]),
    bias: 2,
  };

  var graph = topologicalSort(feedDict);
  var output = forwardPass(f, graph);

  print('Linear (${feedDict.values}) ->> $output');
}

addAndMultiply() {
  var x = Input();
  var y = Input();
  var z = Input();

  var f1 = Add([x, y, z]);

  var feedDict = {x: 4, y: 5, z: 10};

  var graph = topologicalSort(feedDict);
  var output1 = forwardPass(f1, graph);

  print('$x + $y + $z = $output1');

  var f2 = Multiply([x, y, f1]);

  graph = topologicalSort(feedDict);
  var output2 = forwardPass(f2, graph);

  print('$x * $y * $output1 = $output2');
}
