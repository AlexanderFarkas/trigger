import '../trigger/form_trigger_impl.dart';

class DisablingFormTriggerImpl<T> extends FormTriggerImpl<T> {
  DisablingFormTriggerImpl([T? value]) : super(value, _onInvalidValue);

  static void _onInvalidValue(InvalidKeyDetails details) {
    details.disable();
  }
}
