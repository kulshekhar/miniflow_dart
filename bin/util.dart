import 'input_node.dart';
import 'node.dart';

List<Node> topologicalSort(Map<Node, dynamic> feedDict) {
  final inputNodes = feedDict.keys.toList();

  final Map<Node, _NodeGraph> G = {};
  List<Node> nodes = inputNodes.map((v) => v).toList();

  while (nodes.length > 0) {
    final n = nodes.removeAt(0);
    if (!G.containsKey(n)) {
      G[n] = new _NodeGraph();
    }

    n.outboundNodes.forEach((Node m) {
      if (!G.containsKey(m)) {
        G[m] = new _NodeGraph();
      }

      G[n].outbound.add(m);
      G[m].inbound.add(n);
      nodes.add(m);
    });
  }

  final L = <Node>[];
  var S = inputNodes.toSet();

  while (S.length > 0) {
    final n = S.last;
    S.remove(n);

    if (n is InputNode) {
      n.value = feedDict[n];
    }

    L.add(n);
    n.outboundNodes.forEach((m) {
      G[n].outbound.remove(m);
      G[m].inbound.remove(n);

      if (G[m].inbound.length == 0) {
        S.add(m);
      }
    });
  }

  return L;
}

class _NodeGraph {
  final inbound = new Set();
  final outbound = new Set();
}

forwardPass(Node outputNode, List<Node> sortedNodes) {
  sortedNodes.forEach((n) {
    n.forward();
  });

  return outputNode.value;
}

dot(l1, l2) {
  final f = l1[0] is List //
      ? dot2 //
      : l1[0] is num //
          ? dot1
          : throw 'Invalid input';

  return f(l1, l2);
}

num dot1([List<num> l1 = const [], List<num> l2 = const []]) {
  if (l1.length != l2.length) throw 'Only lists of the same length allowed';

  var total = 0;
  for (var i = 0, l = l1.length; i < l; i++) {
    total += l1[i] * l2[i];
  }

  return total;
}

List<num> dot2([List<List<num>> l1 = const [], List<List<num>> l2 = const []]) {
  final result = <num>[];

  if (l1.length == 0 || l2.length == 0) throw 'One or more matrices are empty';

  final rows = l1.length;
  final columns = l1[0].length;

  if (l2.length != columns) throw 'The matrices cannot be multiplied';

  for (var i = 0; i < rows; i++) {
    var total = 0;
    for (var j = 0; j < columns; j++) {
      total += l1[i][j] * l2[j][i];
    }
    result.add(total);
  }

  return result;
}
