import 'package:valform/src/multi_valform/multi_valform_impl.dart';

class VfReproduceImpl<T> extends MultiValformImpl<T> {
  VfReproduceImpl([T? value]) : super(_onInvalidKey, value);

  static bool _onInvalidKey(key, ownerId, cells, setSealed) => false;
}
