import 'package:meta/meta.dart';
import '../trigger/base_form_trigger.dart';
import '../trigger/form_trigger_impl.dart';
import '../trigger/base_field_trigger.dart';

abstract class FieldTriggerWrapper<T> implements BaseFieldTrigger<T> {
  @protected
  final BaseFormTrigger<T> _impl;

  FieldTriggerWrapper(this._impl);

  @override
  T? access(key) {
    return _impl.access(key, fieldId: defaultFieldId);
  }

  @internal
  @override
  bool isValid(value) => _impl.isValid(value, fieldId: defaultFieldId);

  @internal
  @override
  void setDefault(value) => _impl.setDefault(value, fieldId: defaultFieldId);

  @override
  bool get isEnabled => _impl.isEnabled;

  @override
  bool get isDisabled => _impl.isDisabled;
}
