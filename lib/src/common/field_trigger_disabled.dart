import '../trigger/base_field_trigger.dart';

mixin FieldTriggerDisabled<T> implements BaseFieldTrigger<T> {
  @override
  access(key) {
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
