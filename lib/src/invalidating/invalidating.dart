import '../common/form_trigger_disabled.dart';
import '../common/form_trigger_wrapper.dart';
import '../common/field_trigger_disabled.dart';
import '../common/field_trigger_wrapper.dart';

import 'invalidating_impl.dart';

class _FormDisabled<T> with FormTriggerDisabled<T> implements FormTrigger<T> {
  const _FormDisabled();
}

class _FieldDisabled<T> with FieldTriggerDisabled<T> implements FieldTrigger<T> {
  const _FieldDisabled();
}

class FormTrigger<T> extends FormTriggerWrapper<T> {
  FormTrigger([T? value]) : super(InvalidatingFormTriggerImpl(value));
  const factory FormTrigger.disabled() = _FormDisabled;
}

class FieldTrigger<T> extends FieldTriggerWrapper<T> {
  FieldTrigger([T? value]) : super(InvalidatingFormTriggerImpl(value));
  const factory FieldTrigger.disabled() = _FieldDisabled;
}
