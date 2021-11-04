import 'package:valform/src/boolean_valform.dart';

mixin BooleanValformMixin {
  List<BooleanValform> get valforms;

  bool anyIsNotSealed() => valforms.any((element) => element.isNotSealed);
  bool allSealed() => valforms.every((element) => element.isSealed);
}