import '../valform/multi_field_valform.dart';

mixin MultiFieldValformSealed<T> implements MultiFieldValform<T> {
  @override
  access(key, {required fieldId}) {
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
