part of 'validation_pipeline.dart';

extension NullableValidationPipelineX on ValidationPipeline<String?> {
  ValidationPipeline<String> notNull({required String error}) {
    if (_value == null) {
      _addValidator(_Validator(
        value: _value,
        validator: (_) => error,
      ));
      return ValidationPipeline._(_value ?? "", _validators);
    } else {
      return ValidationPipeline._(_value!, _validators);
    }
  }
}
