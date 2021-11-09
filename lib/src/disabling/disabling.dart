import '../common/form_trigger_disabled.dart';
import '../common/form_trigger_wrapper.dart';
import 'disabling_impl.dart';

class _FormDisabled<T> with FormTriggerDisabled<T> implements DisablingFormTrigger<T> {
  const _FormDisabled();
}

class DisablingFormTrigger<T> extends FormTriggerWrapper<T> {
  DisablingFormTrigger([T? value]) : super(DisablingFormTriggerImpl(value));
  const factory DisablingFormTrigger.disabled() = _FormDisabled;
}
