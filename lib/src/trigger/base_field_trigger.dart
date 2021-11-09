import 'trigger.dart';

abstract class BaseFieldTrigger<T> implements Trigger {
  T? access(key);
}