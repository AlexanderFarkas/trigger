import '../trigger/form_trigger_impl.dart';

import 'invalidating.dart';

const _expelled = Object();

class InvalidatingFormTriggerImpl<T> extends FormTriggerImpl<T> implements InvalidatingFormTrigger<T> {
  InvalidatingFormTriggerImpl([T? value]) : super(value, _onInvalidKey);

  static void _onInvalidKey(InvalidKeyDetails details) {
    details.fields[details.ownerId] = _expelled;
  }
}
