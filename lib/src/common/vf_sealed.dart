import 'package:valform/src/multi_valform/multi_valform.dart';

mixin VfSealed<T> implements MultiValform<T> {
  @override
  access(key, {required ownerId}) {
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