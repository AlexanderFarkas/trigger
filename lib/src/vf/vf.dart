import 'package:valform/src/common/single_field_valform_sealed.dart';
import 'package:valform/src/seal/seal.dart';

class Vf<T> extends VfSeal<T> {
  Vf([T? value]) : super(value);
  const factory Vf.sealed() = _VfSealed;
}

class _VfSealed<T> with SingleFieldValformSealed<T> implements Vf<T> {
  const _VfSealed();
}
