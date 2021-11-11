import 'dart:collection';

import 'package:meta/meta.dart';

import 'src/trigger/base_field_trigger.dart';
import 'src/trigger/base_form_trigger.dart';
import 'src/validation_errors.dart';
import 'src/validation_regexp.dart';

typedef _Validator<T> = String? Function();
typedef TriggerErrorBuilder<T> = String? Function(T? content);

mixin ValidatorMixin {
  @protected
  ValidationPipeline validate<T>(T value) => ValidationPipeline<T>(value);
}

class ValidationPipeline<T> {
  final T _value;
  final Queue<_Validator<T>> _validators;

  ValidationPipeline._(this._value, this._validators);
  ValidationPipeline(this._value) : _validators = Queue();

  ValidationPipeline<T> willNotTrigger<K>(
    BaseFieldTrigger<K> trigger, {
    required TriggerErrorBuilder<K> errorBuilder,
  }) {
    _performSideEffect(() => trigger.setDefault(_value));
    _addValidator(() {
      if (trigger.isValid(_value)) {
        return null;
      }
      final content = trigger.access(_value);
      return errorBuilder(content);
    });

    return this;
  }

  ValidationPipeline<T> willNotTriggerForm<K>(
    BaseFormTrigger<K> trigger, {
    required fieldId,
    required TriggerErrorBuilder<K> errorBuilder,
  }) {
    _performSideEffect(() => trigger.setDefault(_value, fieldId: fieldId));
    _addValidator(() {
      if (trigger.isValid(_value, fieldId: fieldId)) {
        return null;
      }
      final content = trigger.access(_value, fieldId: fieldId);
      return errorBuilder(content);
    });
    return this;
  }

  ValidationPipeline<T> custom(String? Function(T value) validator) {
    _addValidator(() => validator(_value));
    return this;
  }

  void _performSideEffect(void Function() sideEffect) => sideEffect();
  void _addValidator(_Validator validator) => _validators.add(validator);

  String? call() {
    for (final validator in _validators) {
      final error = validator();
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}

class _FailedValidatorPipeline<T> extends ValidationPipeline<T> {
  _FailedValidatorPipeline(T value, Queue<_Validator<T>> _validators) : super._(value, _validators);

  @override
  void _performSideEffect(void Function() sideEffect) {}
}

extension NullableValidationPipelineX on ValidationPipeline<String?> {
  ValidationPipeline<String> notNull({required String error}) {
    if (_value == null) {
      return _FailedValidatorPipeline(_value ?? "", _validators);
    } else {
      return ValidationPipeline._(_value!, _validators);
    }
  }
}

extension StringValidationPipelineX on ValidationPipeline<String> {
  ValidationPipeline<String> minLength(
    int length, {
    String? error,
  }) {
    _addValidator(() {
      if (_value.runes.length < length) {
        return error ?? ValidationErrors.instance.minLength(length);
      }
      return null;
    });

    return this;
  }

  ValidationPipeline<String> maxLength(
    int length, {
    String? error,
  }) {
    _addValidator(() {
      if (_value.runes.length > length) {
        return error ?? ValidationErrors.instance.maxLength(length);
      }
      return null;
    });

    return this;
  }

  ValidationPipeline<String> isEmail({String? error}) {
    _addValidator(() {
      if (!emailRegExp.hasMatch(_value)) {
        return error ?? ValidationErrors.instance.email();
      }
      return null;
    });

    return this;
  }
}
