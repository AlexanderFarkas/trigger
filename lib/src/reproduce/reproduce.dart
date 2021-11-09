import '../common/multi_field_valform_sealed.dart';
import '../common/multi_field_valform_wrapper.dart';
import '../common/single_field_valform_sealed.dart';
import '../common/single_field_valform_wrapper.dart';

import 'reproduce_impl.dart';

class _MultiSealed<T> with MultiFieldValformSealed<T> implements MultiVfReproduce<T> {
  const _MultiSealed();
}

class _SingleSealed<T> with SingleFieldValformSealed<T> implements VfReproduce<T> {
  const _SingleSealed();
}

class MultiVfReproduce<T> extends MultiFieldValformWrapper<T> {
  MultiVfReproduce([T? value]) : super(VfReproduceImpl(value));
  const factory MultiVfReproduce.sealed() = _MultiSealed;
}

class VfReproduce<T> extends SingleFieldValformWrapper<T> {
  VfReproduce([T? value]) : super(VfReproduceImpl(value));
  const factory VfReproduce.sealed() = _SingleSealed;
}
