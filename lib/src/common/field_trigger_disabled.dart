import 'package:meta/meta.dart';
import 'package:trigger/src/trigger/base_form_trigger.dart';

import '../../trigger.dart';
import '../trigger/base_field_trigger.dart';

mixin FieldTriggerDisabled<T extends Object> implements BaseFieldTrigger<T> {
  @override
  T? access(key) {
    if (Trigger.shouldUseBooleans<T>()) {
      return false as T;
    } else {
      return null;
    }
  }

  @internal
  @override
  bool isValid(value) => true;

  @internal
  @override
  void setDefault(value) {}

  @override
  bool get isEnabled => false;

  @override
  bool get isDisabled => true;
}

mixin FieldBoolTriggerDisabled implements BaseFieldBoolTrigger {
  @override
  bool access(key) {
    return false;
  }

  @internal
  @override
  bool isValid(value) => true;

  @internal
  @override
  void setDefault(value) {}

  @override
  bool get isEnabled => false;

  @override
  bool get isDisabled => true;
}
