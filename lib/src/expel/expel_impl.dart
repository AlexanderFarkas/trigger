import '../valform/multi_field_valform_impl.dart';

import 'expel.dart';

const _expelled = Object();

class VfExpelImpl<T> extends MultiFieldValformImpl<T> implements MultiVfExpel<T> {
  VfExpelImpl([T? value]) : super(value, _onInvalidKey);

  static void _onInvalidKey(InvalidKeyDetails details) {
    details.fields[details.ownerId] = _expelled;
  }
}
