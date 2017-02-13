class Node {
  List inboundNodes = [];
  List outboundNodes = [];
  dynamic nodeValue;

  dynamic get value => nodeValue;
  void set value(newValue) {
    nodeValue = newValue;
  }

  Node([this.inboundNodes = const []]) {
    inboundNodes.forEach((Node n) {
      n.outboundNodes.add(this);
    });
  }

  void forward() {
    throw 'Not Implemented';
  }

  void backward() {
    throw 'Not Implemented';
  }

  num operator +(Node n) => value + n.value;

  @override
  toString() => value.toString();
}
