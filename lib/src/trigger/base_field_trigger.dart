import 'trigger.dart';
import 'package:meta/meta.dart';

abstract class BaseFieldTrigger<T> implements Trigger {
  T? access(key);

  @internal
  void setDefault(fieldValue);

  @internal
  bool isValid(key);
}