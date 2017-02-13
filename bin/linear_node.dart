import 'input_node.dart';
import 'node.dart';
import 'util.dart';

class Linear extends Node {
  Input<List<double>> _inputs;
  Input<List<double>> _weights;
  Input<double> _bias;

  Linear(this._inputs, this._weights, this._bias)
      : super([_inputs, _weights, _bias]);

  @override
  forward() {
    final inputs = _inputs.value;
    final weights = _weights.value;
    final bias = _bias.value;

    value = dot(inputs, weights) + bias;
  }
}
