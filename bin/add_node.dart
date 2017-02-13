import 'input_node.dart';
import 'node.dart';

class AddNode extends Node {
  AddNode(Input x, Input y) : super([x, y]);
  AddNode.fromList(List<Input> l) : super(l);

  @override
  forward() {
    var total = 0;
    inboundNodes.forEach((Node n) {
      total += n.value;
    });
    value = total;
  }
}

AddNode Add(x, [y]) =>
    x is List<Node> ? new AddNode.fromList(x) : new AddNode(x, y);
