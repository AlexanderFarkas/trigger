import '../common/multi_field_valform_sealed.dart';
import '../common/multi_field_valform_wrapper.dart';
import '../common/single_field_valform_sealed.dart';
import '../common/single_field_valform_wrapper.dart';
import 'seal_impl.dart';

class _MultiSealed<T> with MultiFieldValformSealed<T> implements MultiVfSeal<T> {
  const _MultiSealed();
}

class _SingleSealed<T> with SingleFieldValformSealed<T> implements VfSeal<T> {
  const _SingleSealed();
}

class MultiVfSeal<T> extends MultiFieldValformWrapper<T> {
  MultiVfSeal([T? value]) : super(VfSealImpl(value));
  const factory MultiVfSeal.sealed() = _MultiSealed;
}

class VfSeal<T> extends SingleFieldValformWrapper<T> {
  VfSeal([T? value]) : super(VfSealImpl(value));
  const factory VfSeal.sealed() = _SingleSealed;
}
