import 'package:valform/src/vf_wrapper.dart';

import 'expell_impl.dart';
import 'expell_sealed.dart';

class VfExpell<T> extends VfWrapper<T> {
  VfExpell([T? value]) : super(VfExpellImpl(value));
  const factory VfExpell.sealed() = VfExpellSealed;
}
