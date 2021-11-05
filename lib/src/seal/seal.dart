
import 'package:valform/src/vf_wrapper.dart';

import 'seal_impl.dart';
import 'seal_sealed.dart';

class VfSeal<T> extends VfWrapper<T> {
  VfSeal([T? value]) : super(VfSealImpl(value));
  const factory VfSeal.sealed() = VfSealSealed;
}
