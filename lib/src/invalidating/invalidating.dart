import '../common/field_trigger_disabled.dart';
import '../common/field_trigger_wrapper.dart';
import '../common/form_trigger_disabled.dart';
import '../common/form_trigger_wrapper.dart';
import 'invalidating_impl.dart';

class FormBoolTrigger extends FormBoolTriggerWrapper {
  FormBoolTrigger() : super(InvalidatingFormTriggerImpl<bool>(true));
  const factory FormBoolTrigger.disabled() = _FormBoolDisabled;
}

class _FormBoolDisabled with FormBoolTriggerDisabled implements FormBoolTrigger {
  const _FormBoolDisabled();
}

/////////////////////////////////

class FormTrigger<T extends Object> extends FormTriggerWrapper<T> {
  FormTrigger(T value) : super(InvalidatingFormTriggerImpl(value));
  const factory FormTrigger.disabled() = _FormDisabled;
}

class _FormDisabled<T extends Object> with FormTriggerDisabled<T> implements FormTrigger<T> {
  const _FormDisabled();
}

