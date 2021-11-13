import 'package:meta/meta.dart';
import 'trigger.dart';

abstract class BaseFormTrigger<T extends Object> implements Trigger {
  T? access(fieldValue, {required fieldId});

  @internal
  void setDefault(fieldValue, {required fieldId});

  @internal
  bool isValid(fieldValue, {required fieldId});
}

abstract class BaseFormBoolTrigger implements Trigger {
  bool access(fieldValue, {required fieldId});

  @internal
  void setDefault(fieldValue, {required fieldId});

  @internal
  bool isValid(fieldValue, {required fieldId});
}