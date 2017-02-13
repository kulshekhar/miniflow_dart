import 'node.dart';

class Multiply extends Node {
  Multiply(Node x, Node y) : super([x, y]);
  Multiply.fromList(List<Node> l) : super(l);

  @override
  forward() {
    var total = 1;
    inboundNodes.forEach((n) {
      total *= n.value;
    });
    value = total;
  }
}
