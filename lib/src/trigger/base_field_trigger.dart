import 'package:trigger/src/trigger/base_form_trigger.dart';

import 'trigger.dart';
import 'package:meta/meta.dart';

abstract class BaseFieldTrigger<T extends Object> implements Trigger {
  T? access(key);

  @internal
  void setDefault(fieldValue);

  @internal
  bool isValid(key);
}

abstract class BaseFieldBoolTrigger extends Trigger {
  bool access(key);

  @internal
  void setDefault(fieldValue);

  @internal
  bool isValid(key);
}