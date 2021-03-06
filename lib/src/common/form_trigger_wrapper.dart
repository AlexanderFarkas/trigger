import 'package:meta/meta.dart';

import '../trigger/base_form_trigger.dart';

abstract class FormTriggerWrapper<T extends Object> implements BaseFormTrigger<T> {
  @protected
  final BaseFormTrigger<T> _impl;

  FormTriggerWrapper(this._impl);

  @override
  T? access(key, {required fieldId}) {
    return _impl.access(key, fieldId: fieldId);
  }

  @internal
  @override
  void setDefault(value, {required fieldId}) {
    _impl.setDefault(value, fieldId: fieldId);
  }

  @internal
  @override
  bool isValid(value, {required fieldId}) => _impl.isValid(value, fieldId: fieldId);

  @override
  bool get isEnabled => _impl.isEnabled;

  @override
  bool get isDisabled => _impl.isDisabled;
}

abstract class FormBoolTriggerWrapper implements BaseFormBoolTrigger {
  @protected
  final BaseFormTrigger<bool> _impl;

  FormBoolTriggerWrapper(this._impl);

  @override
  bool access(key, {required fieldId}) {
    return _impl.access(key, fieldId: fieldId) as bool;
  }

  @internal
  @override
  void setDefault(value, {required fieldId}) {
    _impl.setDefault(value, fieldId: fieldId);
  }

  @internal
  @override
  bool isValid(value, {required fieldId}) => _impl.isValid(value, fieldId: fieldId);

  @override
  bool get isEnabled => _impl.isEnabled;

  @override
  bool get isDisabled => _impl.isDisabled;
}
