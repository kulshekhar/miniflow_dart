class ArrayClass {
  int _dimension;
  int _rowCount;
  int _colCount;
  int _length;

  int get dimension => _dimension;

  List _list;
  List<num> _list1D;
  List<List<num>> _list2D;

  ArrayClass(List<num> l) {
    _dimension = 1;
    _list1D = l ?? [];
    _list = _list1D;
    _rowCount = 1;
    _colCount = _list1D.length;
    _init();
  }

  ArrayClass.twoDimensional(List<List<num>> l) {
    _dimension = 2;
    _list2D = l ?? [];
    _list = _list2D;
    _rowCount = _list2D.length;
    _validate();
    _init();
  }

  _init() {
    _length = _list.length;
  }

  _validate() {
    for (var i = 0; i < _rowCount; i++) {
      final count = _list2D[i].length;
      if (i == 0) {
        _colCount = count;
      } else if (count != _colCount) throw 'All rows must have the same size';
    }
  }

  ArrayClass get T {
    var l = new List<List<num>>(_dimension == 1 ? _length : _colCount);

    if (_dimension == 1) {
      for (var i = 0; i < _length; i++) {
        l[i] = [_list1D[i]];
      }
    } else {
      for (var col = 0; col < _colCount; col++) {
        var l1 = new List<num>(_rowCount);
        for (var row = 0; row < _rowCount; row++) {
          l1[row] = _list2D[row][col];
        }
        l[col] = l1;
      }
    }

    return new ArrayClass.twoDimensional(l);
  }

  ArrayClass apply(Function f) {
    if (_dimension == 1) {
      final l = new List<num>(_length);
      for (var i = 0; i < _length; i++) {
        l[i] = f(_list1D[i]);
      }
      return new ArrayClass(l);
    }

    final l = new List<List<num>>(_rowCount);
    for (var i = 0; i < _rowCount; i++) {
      final l1 = new List<num>(_colCount);
      for (var j = 0; j < _colCount; j++) {
        l1[j] = f(_list2D[i][j]);
      }
      l[i] = l1;
    }
    return new ArrayClass.twoDimensional(l);
  }

  mean() {
    if (_dimension == 1) {
      return _list1D.fold(0, (num p, num c) => p + c) / _length;
    }
  }

  int get length => _list.length;

  operator [](int i) => _list[i];

  operator *(ArrayClass a) {
    if (_dimension == 1 && a._dimension == 1) return _dot1x1(a);

    if (_dimension == 1 && a._rowCount == _length) return _dot1xN(a);

    if (_colCount == a._rowCount) return _dotMxN(a);

    throw 'The inner dimensions do not match';
  }

  num _dot1x1(ArrayClass a) {
    if (_length != a._length) throw 'The arrays must have the same length';

    num total = 0;
    for (var i = 0; i < _length; i++) {
      total += _list[i] * a[i];
    }

    return total;
  }

  ArrayClass _dot1xN(ArrayClass a) {
    final l = new List<num>(a._colCount);

    for (var i = 0; i < a._colCount; i++) {
      var total = 0;
      for (var j = 0; j < _length; j++) {
        total += _list[j] * a[j][i];
      }
      l[i] = total;
    }

    return new ArrayClass(l);
  }

  ArrayClass _dotMxN(ArrayClass a) {
    final l = new List<List<num>>(_length);

    for (var r1 = 0; r1 < _length; r1++) {
      final l1 = new List<num>(a._colCount);

      for (var i = 0; i < a._colCount; i++) {
        var total = 0;
        for (var j = 0; j < _colCount; j++) {
          total += _list[r1][j] * a[j][i];
        }
        l1[i] = total;
      }

      l[r1] = l1;
    }

    return new ArrayClass.twoDimensional(l);
  }

  ArrayClass operator +(ArrayClass a) {
    if (_dimension == 1 && a._dimension == 1) {
      final l = new List<num>(_length);
      for (var i = 0; i < _length; i++) {
        l[i] = _list1D[i] + a[i];
      }
      return new ArrayClass(l);
    }

    if (a._dimension == 1) {
      return _addRowToMatrix(a);
    }

    final l = new List<List<num>>(_rowCount);
    for (var i = 0; i < _rowCount; i++) {
      final l1 = new List<num>(_colCount);
      for (var j = 0; j < _colCount; j++) {
        l1[j] = _list2D[i][j] + a[i][j];
      }
      l[i] = l1;
    }
    return new ArrayClass.twoDimensional(l);
  }

  ArrayClass _addRowToMatrix(ArrayClass a) {
    if (_colCount != a._length) throw 'Array dimensions do not match';

    final l = new List<List<num>>(_rowCount);
    for (var i = 0; i < _rowCount; i++) {
      final l1 = new List<num>(_colCount);
      for (var j = 0; j < _colCount; j++) {
        l1[j] = _list2D[i][j] + a[j];
      }
      l[i] = l1;
    }
    return new ArrayClass.twoDimensional(l);
  }

  ArrayClass operator -(ArrayClass a) {
    if (_dimension == 1 && a._dimension == 1) {
      final l = new List<num>(_length);
      for (var i = 0; i < _length; i++) {
        l[i] = _list1D[i] - a[i];
      }
      return new ArrayClass(l);
    }

    if (a._dimension == 1) {
      return _subtractRowFromMatrix(a);
    }

    final l = new List<List<num>>(_rowCount);
    for (var i = 0; i < _rowCount; i++) {
      final l1 = new List<num>(_colCount);
      for (var j = 0; j < _colCount; j++) {
        l1[j] = _list2D[i][j] - a[i][j];
      }
      l[i] = l1;
    }
    return new ArrayClass.twoDimensional(l);
  }

  ArrayClass _subtractRowFromMatrix(ArrayClass a) {
    if (_colCount != a._length) throw 'Array dimensions do not match';

    final l = new List<List<num>>(_rowCount);
    for (var i = 0; i < _rowCount; i++) {
      final l1 = new List<num>(_colCount);
      for (var j = 0; j < _colCount; j++) {
        l1[j] = _list2D[i][j] - a[j];
      }
      l[i] = l1;
    }
    return new ArrayClass.twoDimensional(l);
  }

  @override
  toString() => _list.toString();

  List toList() => _list;
}

ArrayClass Array(a) {
  if (a is List) {
    if (a.length == 0) return new ArrayClass.twoDimensional([]);
    if (a[0] is num) return new ArrayClass(a as List<num>);
    return new ArrayClass.twoDimensional(a as List<List<num>>);
  }

  throw 'Invalid parameter';
}
