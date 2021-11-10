import 'package:meta/meta.dart';

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

  @internal
  @override
  bool isValid(value) => false;

  @internal
  @override
  void setDefault(value) {}

  @override
  bool get isEnabled => false;

  @override
  bool get isDisabled => true;
}
