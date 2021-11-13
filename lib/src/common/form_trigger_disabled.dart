import 'package:meta/meta.dart';

import '../../trigger.dart';
import '../trigger/base_form_trigger.dart';

class FormTriggerDisabled<T extends Object> implements BaseFormTrigger<T> {
  @override
  access(fieldValue, {required fieldId}) {
    if (Trigger.shouldUseBooleans<T>()) {
      return false as T;
    } else {
      return null;
    }
  }

  @internal
  @override
  void setDefault(fieldValue, {required fieldId}) {}

  @internal
  @override
  bool isValid(fieldValue, {required fieldId}) => true;

  @override
  bool get isEnabled => false;

  @override
  bool get isDisabled => true;
}

class FormBoolTriggerDisabled implements BaseFormBoolTrigger {
  @override
  access(fieldValue, {required fieldId}) {
    return false;
  }

  @internal
  @override
  void setDefault(fieldValue, {required fieldId}) {}

  @internal
  @override
  bool isValid(fieldValue, {required fieldId}) => true;

  @override
  bool get isEnabled => false;

  @override
  bool get isDisabled => true;
}
