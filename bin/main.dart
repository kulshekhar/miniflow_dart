import 'add_node.dart';
import 'input_node.dart';
import 'mul_node.dart';
import 'util.dart';

main(List<String> args) {
  addAndMultiply();
}

addAndMultiply() {
  var x = new Input();
  var y = new Input();
  var z = new Input();

  var f1 = new Add.fromList([x, y, z]);

  var feedDict = {x: 4, y: 5, z: 10};

  var graph = topologicalSort(feedDict);
  var output = forwardPass(f1, graph);

  print(output);

  var f2 = new Multiply.fromList([x, y, f1]);

  graph = topologicalSort(feedDict);
  output = forwardPass(f2, graph);

  print(output);
}
