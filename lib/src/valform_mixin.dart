import 'package:valform/src/multi_valform.dart';

mixin BooleanValformMixin {
  List<MultiValform> get valforms;

  bool anyIsNotSealed() => valforms.any((element) => element.isNotSealed);
  bool allSealed() => valforms.every((element) => element.isSealed);
}