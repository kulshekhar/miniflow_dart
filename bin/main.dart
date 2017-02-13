import 'add_node.dart';
import 'input_node.dart';
import 'linear_node.dart';
import 'mul_node.dart';
import 'util.dart';

main(List<String> args) {
  linear();
  addAndMultiply();
}

linear() {
  var inputs = new Input<List<double>>();
  var weights = new Input<List<double>>();
  var bias = new Input<double>();

  var f = new Linear(inputs, weights, bias);
  Map<Input, dynamic> feedDict = {
    inputs: [6.0, 14.0, 3.0],
    weights: [0.5, 0.25, 1.4],
    bias: 2,
  };

  var graph = topologicalSort(feedDict);
  var output = forwardPass(f, graph);

  print('Linear (${feedDict.values}) ->> $output');
}

addAndMultiply() {
  var x = new Input();
  var y = new Input();
  var z = new Input();

  var f1 = new Add.fromList([x, y, z]);

  var feedDict = {x: 4, y: 5, z: 10};

  var graph = topologicalSort(feedDict);
  var output1 = forwardPass(f1, graph);

  print('$x + $y + $z = $output1');

  var f2 = new Multiply.fromList([x, y, f1]);

  graph = topologicalSort(feedDict);
  var output2 = forwardPass(f2, graph);

  print('$x * $y * $output1 = $output2');
}
