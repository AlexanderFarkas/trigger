import 'valform.dart';

abstract class MultiFieldValform<T> extends Valform {
  T? access(key, {required fieldId});
}