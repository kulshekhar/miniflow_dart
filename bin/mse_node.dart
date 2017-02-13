import 'array.dart';
import 'input_node.dart';
import 'node.dart';

class MSENode extends Node {
  MSENode(InputNode y, InputNode a) : super([y, a]);

  @override
  forward() {
    ArrayClass y = inboundNodes[0].value;
    ArrayClass a = inboundNodes[1].value;

    value = (y - a).apply((v) => v * v).mean();
  }
}

MSENode MSE(InputNode y, InputNode a) => new MSENode(y, a);
