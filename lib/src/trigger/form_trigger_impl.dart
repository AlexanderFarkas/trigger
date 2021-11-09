import 'base_form_trigger.dart';

class InvalidKeyDetails {
  final dynamic fieldValue;
  final dynamic ownerId;
  final Map fields;
  final Function() disable;

  InvalidKeyDetails({
    required this.fieldValue,
    required this.ownerId,
    required this.fields,
    required this.disable,
  });
}

const defaultFieldId = Object();

typedef OnInvalidKey = void Function(InvalidKeyDetails);

abstract class FormTriggerImpl<T> implements BaseFormTrigger<T> {

  // Triger value - first value after trigger was enabled
  final _fieldsToTriggerValue = {};
  final T? _content;

  bool _isDisabled;

  final OnInvalidKey? _handler;

  FormTriggerImpl([
    T? content,
    OnInvalidKey? handler,
  ])  : _content = content,
        _handler = handler,
        _isDisabled = false;

  @override
  bool get isDisabled => _isDisabled;
  @override
  bool get isEnabled => !isDisabled;

  @override
  T? access(fieldValue, {required fieldId}) {
    final isAllowed = _checkValidity(fieldValue, fieldId) && !_isDisabled;
    if (T == dynamic && _content == null) {
      if (isAllowed) {
        return true as T;
      } else {
        return false as T;
      }
    } else {
      if (isAllowed) {
        return _content;
      } else {
        return null;
      }
    }
  }

  bool _checkValidity(fieldValue, fieldId) {
    final savedKey = _fieldsToTriggerValue[fieldId];
    if (savedKey == null) {
      _fieldsToTriggerValue[fieldId] = fieldValue;
    }

    final handler = _handler;
    if (_fieldsToTriggerValue[fieldId] != fieldValue) {
      handler?.call(InvalidKeyDetails(
        fieldValue: fieldValue,
        ownerId: fieldId,
        fields: _fieldsToTriggerValue,
        disable: () => _isDisabled = true,
      ));

      return false;
    }
    return !_isDisabled;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FormTriggerImpl &&
            runtimeType == other.runtimeType
            /// Only sealed valforms are considered equal to each other
            &&
            (isDisabled && other.isDisabled);
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
