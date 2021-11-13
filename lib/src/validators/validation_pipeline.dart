import 'dart:collection';

import 'package:meta/meta.dart';

import '../trigger/base_field_trigger.dart';
import '../trigger/base_form_trigger.dart';
import '../validation_errors.dart';
import '../validation_regexp.dart';

part 'nullable_string_pipeline.dart';
part 'string_pipeline.dart';

typedef _ValidatorFunction<T> = String? Function(T value);
typedef _PipelineBuilder<T> = ValidationPipeline<T> Function(ValidationPipeline<T>);
enum OnErrorStrategy {
  breakAndInvalidate,
  next,
}

enum OnValidStrategy {
  breakAndValidate,
  next,
}

typedef _SideEffect<T> = void Function(T value);

class _Validator {
  final dynamic value;
  final _ValidatorFunction<dynamic> validator;
  final _SideEffect<dynamic>? sideEffect;
  final OnValidStrategy onValid;
  final OnErrorStrategy onError;

  static const defaultOnValid = OnValidStrategy.next;
  static const defaultOnError = OnErrorStrategy.breakAndInvalidate;

  _Validator({
    required this.validator,
    required this.value,
    this.sideEffect,
    OnValidStrategy? onValid,
    OnErrorStrategy? onError,
  })  : onValid = onValid ?? defaultOnValid,
        onError = onError ?? defaultOnError;
}

typedef TriggerErrorBuilder<T> = String? Function(T content);

mixin ValidatorMixin {
  @protected
  ValidationPipeline<T> validate<T>(T value) => ValidationPipeline<T>(value);
}

class ValidationPipeline<T> {
  final T _value;
  final Queue<_Validator> _validators;

  const ValidationPipeline._(this._value, this._validators);
  ValidationPipeline(this._value) : _validators = Queue();

  ValidationPipeline<T> isValidatedBy<K extends Object>(
    BaseFieldTrigger<K> trigger, {
    TriggerErrorBuilder<K>? errorBuilder,
  }) {
    _addValidator(_Validator(
      value: _value,
      sideEffect: (value) => trigger.setDefault(value),
      validator: (value) {
        if (trigger.isValid(value)) {
          trigger.access(value);
          return null;
        }
        final content = trigger.access(value);
        return errorBuilder != null
            ? errorBuilder(content!)
            : ValidationErrors.instance.defaultError();
      },
    ));

    return this;
  }

  ValidationPipeline<T> isNotValidatedBy<K extends Object>(
    BaseFieldTrigger<K> trigger, {
    String? error,
  }) {
    _addValidator(_Validator(
      value: _value,
      sideEffect: (value) => trigger.setDefault(value),
      validator: (value) {
        final String? result =
            trigger.isValid(value) ? (error ?? ValidationErrors.instance.defaultError()) : null;
        trigger.access(value);
        return result;
      },
    ));

    return this;
  }

  ValidationPipeline<T> isValidatedByBool(
    BaseFieldBoolTrigger trigger, {
    String? error,
  }) {
    _addValidator(_Validator(
      value: _value,
      sideEffect: (value) => trigger.setDefault(value),
      validator: (value) =>
          trigger.access(value) ? null : (error ?? ValidationErrors.instance.defaultError()),
    ));

    return this;
  }

  ValidationPipeline<T> isNotValidatedByBool(
    BaseFieldBoolTrigger trigger, {
    String? error,
  }) {
    _addValidator(_Validator(
      value: _value,
      sideEffect: (value) => trigger.setDefault(value),
      validator: (value) =>
          trigger.access(value) ? (error ?? ValidationErrors.instance.defaultError()) : null,
    ));

    return this;
  }

  ValidationPipeline<T> isValidatedByForm<K extends Object>(
    BaseFormTrigger<K> trigger, {
    required fieldId,
    TriggerErrorBuilder<K>? errorBuilder,
  }) {
    _addValidator(_Validator(
      value: _value,
      sideEffect: (value) => trigger.setDefault(value, fieldId: fieldId),
      validator: (value) {
        if (trigger.isValid(value, fieldId: fieldId)) {
          trigger.access(value, fieldId: fieldId);
          return null;
        }
        final content = trigger.access(value, fieldId: fieldId);
        return errorBuilder != null
            ? errorBuilder(content!)
            : ValidationErrors.instance.defaultError();
      },
    ));
    return this;
  }

  ValidationPipeline<T> isNotValidatedByForm<K extends Object>(
    BaseFormTrigger<K> trigger, {
    required fieldId,
    String? error,
  }) {
    _addValidator(_Validator(
      value: _value,
      sideEffect: (value) => trigger.setDefault(value, fieldId: fieldId),
      validator: (value) {
        final String? result = trigger.isValid(value, fieldId: fieldId)
            ? (error ?? ValidationErrors.instance.defaultError())
            : null;
        trigger.access(value, fieldId: fieldId);
        return result;
      },
    ));
    return this;
  }

  ValidationPipeline<T> isValidatedByFormBool(
    BaseFormBoolTrigger trigger, {
    required fieldId,
    String? error,
  }) {
    _addValidator(_Validator(
      value: _value,
      sideEffect: (value) => trigger.setDefault(value, fieldId: fieldId),
      validator: (value) => trigger.access(value, fieldId: fieldId)
          ? (error ?? ValidationErrors.instance.defaultError())
          : null,
    ));
    return this;
  }

  ValidationPipeline<T> isNotValidatedByFormBool(
    BaseFormBoolTrigger trigger, {
    required fieldId,
    String? error,
  }) {
    _addValidator(_Validator(
      value: _value,
      sideEffect: (value) => trigger.setDefault(value, fieldId: fieldId),
      validator: (value) => trigger.access(value, fieldId: fieldId)
          ? null
          : (error ?? ValidationErrors.instance.defaultError()),
    ));
    return this;
  }

  ValidationPipeline<T> custom(String? Function(T value) validator) {
    _addValidator(_Validator(
      value: _value,
      validator: (value) => validator(value),
    ));
    return this;
  }

  ValidationPipeline<T> _withStrategy(
    _PipelineBuilder<T> pipelineBuilder, {
    OnValidStrategy onValid = _Validator.defaultOnValid,
    OnErrorStrategy onError = _Validator.defaultOnError,
  }) {
    _addValidator(_Validator(
      value: _value,
      validator: (value) => pipelineBuilder(ValidationPipeline(value))(),
      onError: onError,
      onValid: onValid,
    ));
    return this;
  }

  ValidationPipeline<T> endIfValid(_PipelineBuilder<T> pipelineBuilder) => _withStrategy(
        pipelineBuilder,
        onValid: OnValidStrategy.breakAndValidate,
        onError: OnErrorStrategy.next,
      );

  ValidationPipeline<T> equals(T? other, {required String error}) {
    _addValidator(_Validator(
      value: _value,
      validator: (value) {
        if (value != other) {
          return error;
        }
        return null;
      },
    ));

    return this;
  }

  void _addValidator(_Validator validator) => _validators.add(validator);

  String? call() {
    for (final validator in _validators) {
      validator.sideEffect?.call(validator.value);
    }
    for (final validator in _validators) {
      final error = validator.validator(validator.value);
      if (error != null) {
        if (validator.onError == OnErrorStrategy.breakAndInvalidate) {
          return error;
        } else {
          continue;
        }
      } else if (validator.onValid == OnValidStrategy.breakAndValidate) {
        return null;
      }
    }
    return null;
  }
}
