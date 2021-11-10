import 'package:meta/meta.dart';
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

  @internal
  @override
  void setDefault(value, {required fieldId}) {}

  @internal
  @override
  bool isValid(value, {required fieldId}) => false;

  @override
  bool get isEnabled => false;

  @override
  bool get isDisabled => true;
}
