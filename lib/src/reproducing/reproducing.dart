import '../common/form_trigger_disabled.dart';
import '../common/form_trigger_wrapper.dart';
import '../common/field_trigger_disabled.dart';
import '../common/field_trigger_wrapper.dart';

import 'reproducing_impl.dart';

class _FormDisabled<T> with FormTriggerDisabled<T> implements ReproducingFormTrigger<T> {
  const _FormDisabled();
}

class _FieldDisabled<T> with FieldTriggerDisabled<T> implements ReproducingFieldTrigger<T> {
  const _FieldDisabled();
}

class ReproducingFormTrigger<T> extends FormTriggerWrapper<T> {
  ReproducingFormTrigger([T? value]) : super(ReproducingFormTriggerImpl(value));
  const factory ReproducingFormTrigger.disabled() = _FormDisabled;
}

class ReproducingFieldTrigger<T> extends FieldTriggerWrapper<T> {
  ReproducingFieldTrigger([T? value]) : super(ReproducingFormTriggerImpl(value));
  const factory ReproducingFieldTrigger.disabled() = _FieldDisabled;
}
