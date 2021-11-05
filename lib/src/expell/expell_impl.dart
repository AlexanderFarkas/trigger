
import 'package:valform/src/multi_valform/multi_valform_impl.dart';

import 'expell.dart';

const _expelled = Object();

class VfExpellImpl<T> extends MultiValformImpl<T> implements VfExpell<T> {
  VfExpellImpl([T? value]) : super(_onInvalidKey, value);

  static bool _onInvalidKey(key, ownerId, cells, setSealed) {
    cells[ownerId] = _expelled;
    return false;
  }
}