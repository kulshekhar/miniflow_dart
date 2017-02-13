class Node {
  List inboundNodes = [];
  List outboundNodes = [];
  dynamic value;

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
}
