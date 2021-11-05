import 'package:valform/src/multi_valform/multi_valform_impl.dart';

class VfSealImpl<T> extends MultiValformImpl<T> {
  VfSealImpl([T? value]) : super(value, _onInvalidKey);

  static void _onInvalidKey(InvalidKeyDetails details) {
    details.seal();
  }
}
