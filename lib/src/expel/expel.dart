import 'package:valform/src/common/vf_wrapper.dart';

import 'expel_impl.dart';
import 'expel_sealed.dart';

class VfExpel<T> extends VfWrapper<T> {
  VfExpel([T? value]) : super(VfExpelImpl(value));
  const factory VfExpel.sealed() = VfExpellSealed;
}
