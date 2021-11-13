import '../common/field_trigger_disabled.dart';
import '../common/field_trigger_wrapper.dart';
import '../common/form_trigger_disabled.dart';
import '../common/form_trigger_wrapper.dart';
import 'reproducing_impl.dart';

class _FormBoolDisabled with FormBoolTriggerDisabled implements ReproducingFormBoolTrigger {
  const _FormBoolDisabled();
}

class ReproducingFormBoolTrigger extends FormBoolTriggerWrapper {
  ReproducingFormBoolTrigger() : super(ReproducingFormTriggerImpl<bool>(true));
  const factory ReproducingFormBoolTrigger.disabled() = _FormBoolDisabled;
}

/////////////////////////////////

class _FormDisabled<T extends Object>
    with FormTriggerDisabled<T>
    implements ReproducingFormTrigger<T> {
  const _FormDisabled();
}

class ReproducingFormTrigger<T extends Object> extends FormTriggerWrapper<T> {
  ReproducingFormTrigger(T value) : super(ReproducingFormTriggerImpl(value));
  const factory ReproducingFormTrigger.disabled() = _FormDisabled;
}

/////////////////////////////////

class _FieldBoolDisabled with FieldBoolTriggerDisabled implements ReproducingFieldBoolTrigger {
  const _FieldBoolDisabled();
}

class ReproducingFieldBoolTrigger extends FieldBoolTriggerWrapper {
  ReproducingFieldBoolTrigger() : super(ReproducingFormTriggerImpl<bool>(true));
  const factory ReproducingFieldBoolTrigger.disabled() = _FieldBoolDisabled;
}

/////////////////////////////////

class _FieldDisabled<T extends Object>
    with FieldTriggerDisabled<T>
    implements ReproducingFieldTrigger<T> {
  const _FieldDisabled();
}

class ReproducingFieldTrigger<T extends Object> extends FieldTriggerWrapper<T> {
  ReproducingFieldTrigger(T value) : super(ReproducingFormTriggerImpl(value));
  const factory ReproducingFieldTrigger.disabled() = _FieldDisabled;
}
