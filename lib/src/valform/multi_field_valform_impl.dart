import 'package:valform/src/valform/multi_field_valform.dart';

class InvalidKeyDetails {
  final dynamic key;
  final dynamic ownerId;
  final Map fields;
  final Function() seal;

  InvalidKeyDetails({
    required this.key,
    required this.ownerId,
    required this.fields,
    required this.seal,
  });
}

const defaultFieldId = Object();

typedef OnInvalidKey = void Function(InvalidKeyDetails);

abstract class MultiFieldValformImpl<T> implements MultiFieldValform<T> {
  final _fields = {};
  final T? _value;

  bool _isSealed;

  final OnInvalidKey? _handler;

  MultiFieldValformImpl([
    T? value,
    OnInvalidKey? handler,
  ])  : _value = value,
        _handler = handler,
        _isSealed = false;

  @override
  bool get isSealed => _isSealed;
  @override
  bool get isNotSealed => !isSealed;

  @override
  T? access(key, {required fieldId}) {
    final isAllowed = _checkValidity(key, fieldId) && !_isSealed;
    if (T == dynamic && _value == null) {
      if (isAllowed) {
        return true as T;
      } else {
        return false as T;
      }
    } else {
      if (isAllowed) {
        return _value;
      } else {
        return null;
      }
    }
  }

  bool _checkValidity(key, ownerId) {
    final savedKey = _fields[ownerId];
    if (savedKey == null) {
      _fields[ownerId] = key;
    }

    final handler = _handler;
    if (_fields[ownerId] != key) {
      handler?.call(InvalidKeyDetails(
        key: key,
        ownerId: ownerId,
        fields: _fields,
        seal: () => _isSealed = true,
      ));

      return false;
    }
    return !_isSealed;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MultiFieldValformImpl &&
            runtimeType == other.runtimeType
            /// Only sealed valforms are considered equal to each other
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
