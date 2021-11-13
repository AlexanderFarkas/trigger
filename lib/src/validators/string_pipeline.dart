part of 'validation_pipeline.dart';

extension StringValidationPipelineX on ValidationPipeline<String> {
  ValidationPipeline<String> minLength(
    int length, {
    String? error,
  }) {
    _addValidator(_Validator(
      value: _value,
      validator: (value) {
        if (value.runes.length < length) {
          return error ?? ValidationErrors.instance.minLength(length);
        }
        return null;
      },
    ));

    return this;
  }

  ValidationPipeline<String> maxLength(
    int length, {
    String? error,
  }) {
    _addValidator(_Validator(
        value: _value,
        validator: (value) {
          if (value.runes.length > length) {
            return error ?? ValidationErrors.instance.maxLength(length);
          }
          return null;
        }));

    return this;
  }

  ValidationPipeline<String> isEmail({String? error}) {
    _addValidator(_Validator(
      value: _value,
      validator: (value) {
        if (!emailRegExp.hasMatch(value)) {
          return error ?? ValidationErrors.instance.email();
        }
        return null;
      },
    ));

    return this;
  }
}
