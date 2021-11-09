import 'package:meta/meta.dart';
import '../valform/multi_field_valform.dart';
import '../valform/multi_field_valform_impl.dart';

abstract class MultiFieldValformWrapper<T> implements MultiFieldValform<T> {
  @protected
  final MultiFieldValform<T> _impl;

  MultiFieldValformWrapper(this._impl);

  @override
  T? access(key, {required fieldId}) {
    return _impl.access(key, fieldId: fieldId);
  }

  @override
  bool get isNotSealed => _impl.isNotSealed;

  @override
  bool get isSealed => _impl.isSealed;
}
