import 'access_strategy.dart';
import 'multi_valform.dart';



class VfSeal<T> extends MultiValform<T> {
  VfSeal([T? value]) : super(value);
  VfSeal.sealed() : super.sealed();

  @override
  AccessStrategy get strategy => AccessStrategy.sealOnFailure;
}

class VfReproduce<T> extends MultiValform<T> {
  VfReproduce([T? value]) : super(value);
  VfReproduce.sealed() : super.sealed();

  @override
  AccessStrategy get strategy => AccessStrategy.reproduce;
}

class VfExpell<T> extends MultiValform<T> {
  VfExpell([T? value]) : super(value);
  VfExpell.sealed() : super.sealed();

  @override
  AccessStrategy get strategy => AccessStrategy.expelOnFailure;
}

class Vf<T> extends VfSeal<T> {
  Vf([T? value]) : super(value);
  Vf.sealed() : super.sealed();
}

class VfEphemeral<T> {
  bool _isSealed;
  final T? _value;

  VfEphemeral(T value)
      : _value = value,
        _isSealed = false;

  VfEphemeral.sealed()
      : _value = null,
        _isSealed = true;

  bool get isSealed => _isSealed;
  bool get isNotSealed => !isSealed;

  T? access() {
    T? saveState = _getValue();
    _isSealed = true;
    return saveState;
  }

  T? _getValue() {
    if (_isSealed) {
      return null;
    } else {
      return _value;
    }
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VfEphemeral &&
            runtimeType == other.runtimeType

            /// 1) Events not spent are never considered equal to any other,
            /// and they will always "fire", forcing the widget to rebuild.
            /// 2) Spent events are considered "empty", so they are all equal.
            &&
            (isSealed && other.isSealed);
  }

  /// 1) If two objects are equal according to the equals method, then hashcode of both must
  /// be the same. Since spent events are all equal, they should produce the same hashcode.
  /// 2) If two objects are NOT equal, hashcode may be the same or not, but it's better
  /// when they are not the same. However, events are mutable, and this could mean the hashcode
  /// of the state could be changed when an event is consumed. To avoid this, we make events
  /// always return the same hashCode.
  @override
  int get hashCode => 0;
}
