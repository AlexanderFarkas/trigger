import 'package:meta/meta.dart';
import '../valform/multi_field_valform.dart';
import '../valform/multi_field_valform_impl.dart';
import '../valform/single_field_valform.dart';

abstract class SingleFieldValformWrapper<T> implements SingleFieldValform<T> {
  @protected
  final MultiFieldValform<T> _impl;

  SingleFieldValformWrapper(this._impl);

  @override
  T? access(key) {
    return _impl.access(key, fieldId: defaultFieldId);
  }

  @override
  bool get isNotSealed => _impl.isNotSealed;

  @override
  bool get isSealed => _impl.isSealed;
}
