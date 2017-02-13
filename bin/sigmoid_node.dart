import 'array.dart';
import 'dart:math' as math;

import 'node.dart';

class SigmoidNode extends Node {
  SigmoidNode(Node n) : super([n]);

  _sigmoid(x) => x is num
      ? 1.0 / (1 + math.exp(-x))
      : x is ArrayClass //
          ? x.apply((v) => 1.0 / (1 + math.exp(-v)))
          : throw 'Cannot calculate the sigmoid of $x - ${x.runtimeType}';

  @override
  forward() {
    value = _sigmoid(inboundNodes[0].value);
  }
}

SigmoidNode Sigmoid(Node n) => new SigmoidNode(n);
