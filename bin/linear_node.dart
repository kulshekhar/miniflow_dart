import 'array.dart';
import 'input_node.dart';
import 'node.dart';
import 'util.dart';

class LinearNode extends Node {
  Input<Array> _inputs;
  Input<Array> _weights;
  Input<Array> _bias;

  LinearNode(this._inputs, this._weights, this._bias)
      : super([_inputs, _weights, _bias]);

  @override
  forward() {
    final inputs = _inputs.value;
    final weights = _weights.value;
    final bias = _bias.value;

    value = inputs * weights + bias;
  }
}

LinearNode Linear(
        Input<Array> inputs, Input<Array> weights, Input<Array> bias) =>
    new LinearNode(inputs, weights, bias);
