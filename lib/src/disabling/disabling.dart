import '../common/field_trigger_disabled.dart';
import '../common/field_trigger_wrapper.dart';
import '../common/form_trigger_disabled.dart';
import '../common/form_trigger_wrapper.dart';
import 'disabling_impl.dart';

class _FormBoolDisabled with FormBoolTriggerDisabled implements DisablingFormBoolTrigger {
  const _FormBoolDisabled();
}

class DisablingFormBoolTrigger extends FormBoolTriggerWrapper {
  DisablingFormBoolTrigger() : super(DisablingFormTriggerImpl<bool>(true));
  const factory DisablingFormBoolTrigger.disabled() = _FormBoolDisabled;
}

/////////////////////////////////

class _FormDisabled<T extends Object>
    with FormTriggerDisabled<T>
    implements DisablingFormTrigger<T> {
  const _FormDisabled();
}

class DisablingFormTrigger<T extends Object> extends FormTriggerWrapper<T> {
  DisablingFormTrigger(T value) : super(DisablingFormTriggerImpl(value));
  const factory DisablingFormTrigger.disabled() = _FormDisabled;
}

/////////////////////////////////

class FieldBoolTrigger extends FieldBoolTriggerWrapper {
  FieldBoolTrigger() : super(DisablingFormTriggerImpl(true));
  const factory FieldBoolTrigger.disabled() = _FieldBoolDisabled;
}

class _FieldBoolDisabled with FieldBoolTriggerDisabled implements FieldBoolTrigger {
  const _FieldBoolDisabled();
}

/////////////////////////////////

class FieldTrigger<T extends Object> extends FieldTriggerWrapper<T> {
  FieldTrigger(T value) : super(DisablingFormTriggerImpl(value));
  const factory FieldTrigger.disabled() = _FieldDisabled;
}

class _FieldDisabled<T extends Object> with FieldTriggerDisabled<T> implements FieldTrigger<T> {
  const _FieldDisabled();
}
