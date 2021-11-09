import 'valform.dart';

abstract class SingleFieldValform<T> implements Valform {
  T? access(key);
}