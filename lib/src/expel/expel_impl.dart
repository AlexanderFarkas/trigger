import 'package:valform/src/multi_valform/multi_valform_impl.dart';

import 'expel.dart';

const _expelled = Object();

class VfExpelImpl<T> extends MultiValformImpl<T> implements VfExpel<T> {
  VfExpelImpl([T? value]) : super(value, _onInvalidKey);

  static void _onInvalidKey(InvalidKeyDetails details) {
    details.cells[details.ownerId] = _expelled;
  }
}
