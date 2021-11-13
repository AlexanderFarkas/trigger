part of 'validation_pipeline.dart';

class _FailedValidatorPipeline<T> extends ValidationPipeline<T> {
  _FailedValidatorPipeline(T value, Queue<_Validator> _validators) : super._(value, _validators);

  @override
  void _performSideEffect(void Function() sideEffect) {}
}

extension NullableValidationPipelineX on ValidationPipeline<String?> {
  ValidationPipeline<String> notNull({required String error}) {
    if (_value == null) {
      _addValidator(_Validator(
        value: _value,
        validator: (_) => error,
      ));
      return _FailedValidatorPipeline(_value ?? "", _validators);
    } else {
      return ValidationPipeline._(_value!, _validators);
    }
  }
}
