import 'package:meta/meta.dart';

import '../../trigger.dart';
import '../trigger/base_field_trigger.dart';

mixin FieldTriggerDisabled<T> implements BaseFieldTrigger<T> {
  @override
  access(key) {
    if (Trigger.shouldUseBooleans<T?>(null)) {
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
