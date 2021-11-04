import 'valforms.dart';

class VfStrictSeal<T> extends VfSeal<T> {
  VfStrictSeal(T value) : super(value);
  VfStrictSeal.sealed() : super.sealed();
}
class VfStrictReproduce<T> extends VfReproduce<T> {
  VfStrictReproduce(T value) : super(value);
  VfStrictReproduce.sealed() : super.sealed();
}
class VfStrictExpell<T> extends VfExpell<T> {
  VfStrictExpell(T value) : super(value);
  VfStrictExpell.sealed() : super.sealed();
}