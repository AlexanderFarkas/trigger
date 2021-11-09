import '../trigger/base_form_trigger.dart';

mixin FormTriggerDisabled<T> implements BaseFormTrigger<T> {
  @override
  access(key, {required fieldId}) {
    if (T == dynamic) {
      return false as T;
    } else {
      return null;
    }
  }

  @override
  bool get isEnabled => false;

  @override
  bool get isDisabled => true;
}
