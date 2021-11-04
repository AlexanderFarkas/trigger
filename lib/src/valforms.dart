import 'access_strategy.dart';
import 'boolean_valform.dart';

class VfSeal<T> extends BooleanValform<T> {
  VfSeal() : super();
  VfSeal.sealed() : super.sealed();

  @override
  AccessStrategy get strategy => AccessStrategy.sealOnFailure;
}

class VfReproduce<T> extends BooleanValform<T> {
  VfReproduce() : super();
  VfReproduce.sealed() : super.sealed();

  @override
  AccessStrategy get strategy => AccessStrategy.reproduce;
}

class VfExpell<T> extends BooleanValform<T> {
  VfExpell() : super();
  VfExpell.sealed() : super.sealed();

  @override
  AccessStrategy get strategy => AccessStrategy.expelOnFailure;
}

class Vf<T> extends VfSeal<T> {
  Vf() : super();
  Vf.sealed() : super.sealed();
}

class VfEthemeral<T> {
  bool _isSealed;
  final T? _value;

  VfEthemeral([T? value])
      : _value = value,
        _isSealed = false;

  VfEthemeral.sealed()
      : _value = null,
        _isSealed = true;

  bool get isSealed => _isSealed;
  bool get isNotSealed => !isSealed;

  /// Returns the event state and consumes the event.
  T? consume() {
    T? saveState = state;
    _isSealed = true;
    return saveState;
  }

  /// Returns the event state.
  T? get state {
    if (_isSealed) {
      return null;
    } else {
      return _value;
    }
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VfEthemeral &&
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
