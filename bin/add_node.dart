import 'input_node.dart';
import 'node.dart';

class Add extends Node {
  Add(Input x, Input y) : super([x, y]);
  Add.fromList(List<Input> l) : super(l);

  @override
  forward() {
    var total = 0;
    inboundNodes.forEach((Node n) {
      total += n.value;
    });
    value = total;
  }
}
