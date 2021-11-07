import 'package:valform/src/valform/valform.dart';

abstract class MultiFieldValform<T> extends Valform {
  T? access(key, {required fieldId});
}