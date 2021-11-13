import 'package:meta/meta.dart';

abstract class Trigger {
  bool get isDisabled ;
  bool get isEnabled;

  @internal
  static bool shouldUseBooleans<T>() {
    return T == bool;
  }
}
