import 'package:meta/meta.dart';
import '../trigger/base_form_trigger.dart';
import '../trigger/form_trigger_impl.dart';

abstract class FormTriggerWrapper<T> implements BaseFormTrigger<T> {
  @protected
  final BaseFormTrigger<T> _impl;

  FormTriggerWrapper(this._impl);

  @override
  T? access(key, {required fieldId}) {
    return _impl.access(key, fieldId: fieldId);
  }

  @override
  bool get isEnabled => _impl.isEnabled;

  @override
  bool get isDisabled => _impl.isDisabled;
}
