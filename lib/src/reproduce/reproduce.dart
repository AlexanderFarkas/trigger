
import 'package:valform/src/common/vf_wrapper.dart';

import 'reproduce_impl.dart';
import 'reproduce_sealed.dart';

class VfReproduce<T> extends VfWrapper<T> {
  VfReproduce([T? value]) : super(VfReproduceImpl(value));
  const factory VfReproduce.sealed() = VfReproduceSealed;
}
