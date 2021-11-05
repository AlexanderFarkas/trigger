import 'package:meta/meta.dart';
import 'package:valform/src/multi_valform/multi_valform.dart';

abstract class VfWrapper<T> implements MultiValform<T> {
  @protected
  final MultiValform<T> _impl;

  VfWrapper(this._impl);

  @override
  T? access(key, {required ownerId}) {
    return _impl.access(key, ownerId: ownerId);
  }

  @override
  bool get isNotSealed => _impl.isNotSealed;

  @override
  bool get isSealed => _impl.isSealed;
}