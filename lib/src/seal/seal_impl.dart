import 'package:valform/src/valform/multi_field_valform_impl.dart';

class VfSealImpl<T> extends MultiFieldValformImpl<T> {
  VfSealImpl([T? value]) : super(value, _onInvalidKey);

  static void _onInvalidKey(InvalidKeyDetails details) {
    details.seal();
  }
}
