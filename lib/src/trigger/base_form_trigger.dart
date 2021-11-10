import 'package:meta/meta.dart';
import 'trigger.dart';

abstract class BaseFormTrigger<T> implements Trigger {
  T? access(fieldValue, {required fieldId});

  @internal
  void setDefault(fieldValue, {required fieldId});

  @internal
  bool isValid(fieldValue, {required fieldId});
}