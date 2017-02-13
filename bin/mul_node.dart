import 'node.dart';

class MultiplyNode extends Node {
  MultiplyNode(Node x, Node y) : super([x, y]);
  MultiplyNode.fromList(List<Node> l) : super(l);

  @override
  forward() {
    var total = 1;
    inboundNodes.forEach((n) {
      total *= n.value;
    });
    value = total;
  }
}

MultiplyNode Multiply(x, [y]) =>
    x is List<Node> ? new MultiplyNode.fromList(x) : new MultiplyNode(x, y);
