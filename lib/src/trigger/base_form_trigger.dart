import 'trigger.dart';

abstract class BaseFormTrigger<T> extends Trigger {
  T? access(fieldValue, {required fieldId});
}