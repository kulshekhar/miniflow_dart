import 'node.dart';

class Add extends Node {
  Add(Node x, Node y) : super([x, y]);
  Add.fromList(List<Node> l) : super(l);

  @override
  forward() {
    var total = 0;
    inboundNodes.forEach((Node n) {
      total += n.value;
    });
    value = total;
  }
}
