import 'package:valform/src/common/multi_field_valform_sealed.dart';
import 'package:valform/src/common/multi_field_valform_wrapper.dart';
import 'package:valform/src/common/single_field_valform_sealed.dart';
import 'package:valform/src/common/single_field_valform_wrapper.dart';

import 'expel_impl.dart';

class _MultiSealed<T> with MultiFieldValformSealed<T> implements MultiVfExpel<T> {
  const _MultiSealed();
}

class _SingleSealed<T> with SingleFieldValformSealed<T> implements VfExpel<T> {
  const _SingleSealed();
}

class MultiVfExpel<T> extends MultiFieldValformWrapper<T> {
  MultiVfExpel([T? value]) : super(VfExpelImpl(value));
  const factory MultiVfExpel.sealed() = _MultiSealed;
}

class VfExpel<T> extends SingleFieldValformWrapper<T> {
  VfExpel([T? value]) : super(VfExpelImpl(value));
  const factory VfExpel.sealed() = _SingleSealed;
}
