import '../valform/single_field_valform.dart';

mixin SingleFieldValformSealed<T> implements SingleFieldValform<T> {
  @override
  access(key) {
    if (T == dynamic) {
      return false as T;
    } else {
      return null;
    }
  }

  @override
  bool get isNotSealed => false;

  @override
  bool get isSealed => true;
}
