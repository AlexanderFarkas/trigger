import 'package:valform/src/valform/valform.dart';

mixin ValformMixin {
  List<Valform> get valforms;

  bool anyIsNotSealed() => valforms.any((element) => element.isNotSealed);
  bool allSealed() => valforms.every((element) => element.isSealed);
}
