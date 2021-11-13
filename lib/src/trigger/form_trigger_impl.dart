import 'base_form_trigger.dart';
import 'trigger.dart';

class FieldDidBecomeValidDetails {
  final dynamic fieldValue;
  final dynamic ownerId;
  final Map fields;
  final Function() disable;

  FieldDidBecomeValidDetails({
    required this.fieldValue,
    required this.ownerId,
    required this.fields,
    required this.disable,
  });
}

const defaultFieldId = Object();

typedef FieldDidBecomeValid = void Function(FieldDidBecomeValidDetails);

abstract class FormTriggerImpl<T extends Object> implements BaseFormTrigger<T> {
  // Triger value - first value after trigger was enabled
  final _fieldsToTriggerValue = {};
  final T? _content;

  bool _isDisabled;

  final FieldDidBecomeValid? _handler;

  FormTriggerImpl([
    T? content,
    FieldDidBecomeValid? handler,
  ])  : _content = content,
        _handler = handler,
        _isDisabled = false;

  @override
  bool get isDisabled => _isDisabled;
  @override
  bool get isEnabled => !isDisabled;

  @override
  T? access(fieldValue, {required fieldId}) {
    setDefault(fieldValue, fieldId: fieldId);
    final isValid = _didFieldBecomeValid(
      fieldValue,
      fieldId,
      fieldDidBecomeValid: _handler,
    );

    if (Trigger.shouldUseBooleans<T>()) {
      if (isValid) {
        return false as T;
      } else {
        return true as T;
      }
    } else {
      if (isValid) {
        return null;
      } else {
        return _content;
      }
    }
  }

  @override
  bool isValid(fieldValue, {required fieldId}) {
    return _didFieldBecomeValid(
      fieldValue,
      fieldId,
    );
  }

  bool _didFieldBecomeValid(fieldValue, fieldId, {FieldDidBecomeValid? fieldDidBecomeValid}) {
    if (_fieldsToTriggerValue[fieldId] != fieldValue) {
      fieldDidBecomeValid?.call(FieldDidBecomeValidDetails(
        fieldValue: fieldValue,
        ownerId: fieldId,
        fields: _fieldsToTriggerValue,
        disable: () => _isDisabled = true,
      ));

      return true;
    }
    return _isDisabled;
  }

  @override
  void setDefault(fieldValue, {required fieldId}) {
    final savedKey = _fieldsToTriggerValue[fieldId];
    if (savedKey == null) {
      _fieldsToTriggerValue[fieldId] = fieldValue;
    }
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
