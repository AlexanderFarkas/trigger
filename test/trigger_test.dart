import 'package:test/test.dart';
import 'package:trigger/src/trigger/base_form_trigger.dart';
import 'package:trigger/trigger.dart';

void main() {
  group("Typed", () {
    const absence = null;
    const content = "Error";

    group("Form", () {
      test('Invalidating', () {
        FormTrigger<String> tg = FormTrigger.disabled();
        expect(tg.accessAsFirst(), equals(absence));

        tg = FormTrigger(content);
        expect(tg.accessAsFirst(), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst("another"), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst(), equals(absence));

        expect(tg.accessAsSecond(), equals(content));
      });
      test('Reproducing', () {
        ReproducingFormTrigger<String> tg = ReproducingFormTrigger.disabled();
        expect(tg.accessAsFirst(), equals(absence));

        tg = ReproducingFormTrigger(content);
        expect(tg.accessAsFirst(), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst("another"), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst(), equals(content));

        expect(tg.accessAsSecond(), equals(content));
      });
      test('Disabling', () {
        DisablingFormTrigger<String> vf = DisablingFormTrigger.disabled();
        expect(vf.accessAsFirst(), equals(absence));

        vf = DisablingFormTrigger(content);
        expect(vf.accessAsFirst(), equals(content));
        expect(vf.isDisabled, equals(false));
        expect(vf.accessAsFirst("another"), equals(absence));
        expect(vf.isDisabled, equals(true));
        expect(vf.accessAsFirst(), equals(absence));

        expect(vf.accessAsSecond(), equals(absence));
      });
    });
    group("Field", () {
      const first = "Value";
      const second = "Value2";

      test('Disabling', () {
        FieldTrigger<String> tg = FieldTrigger.disabled();
        expect(tg.access(first), equals(absence));

        tg = FieldTrigger(content);
        expect(tg.access(first), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(second), equals(absence));
        expect(tg.isDisabled, equals(true));
        expect(tg.access(first), equals(absence));
      });
      test('Reproducing', () {
        ReproducingFieldTrigger<String> tg = ReproducingFieldTrigger.disabled();
        expect(tg.access(first), equals(absence));

        tg = ReproducingFieldTrigger(content);
        expect(tg.access(first), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(second), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(first), equals(content));
      });
    });
  });

  group("Typed by boolean", () {
    const absence = false;
    const content = true;

    group("Form", () {
      test('Invalidating', () {
        FormTrigger<bool> tg = FormTrigger.disabled();
        expect(tg.accessAsFirst(), equals(absence));

        tg = FormTrigger(content);
        expect(tg.accessAsFirst(), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst("another"), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst(), equals(absence));

        expect(tg.accessAsSecond(), equals(content));
      });
      test('Reproducing', () {
        ReproducingFormTrigger<bool> tg = ReproducingFormTrigger.disabled();
        expect(tg.accessAsFirst(), equals(absence));

        tg = ReproducingFormTrigger(content);
        expect(tg.accessAsFirst(), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst("another"), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst(), equals(content));

        expect(tg.accessAsSecond(), equals(content));
      });
      test('Disabling', () {
        DisablingFormTrigger<bool> vf = DisablingFormTrigger.disabled();
        expect(vf.accessAsFirst(), equals(absence));

        vf = DisablingFormTrigger(content);
        expect(vf.accessAsFirst(), equals(content));
        expect(vf.isDisabled, equals(false));
        expect(vf.accessAsFirst("another"), equals(absence));
        expect(vf.isDisabled, equals(true));
        expect(vf.accessAsFirst(), equals(absence));

        expect(vf.accessAsSecond(), equals(absence));
      });
    });
    group("Field", () {
      const first = "Value";
      const second = "Value2";

      test('Disabling', () {
        FieldTrigger<bool> tg = FieldTrigger.disabled();
        expect(tg.access(first), equals(absence));

        tg = FieldTrigger(content);
        expect(tg.access(first), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(second), equals(absence));
        expect(tg.isDisabled, equals(true));
        expect(tg.access(first), equals(absence));
      });
      test('Reproducing', () {
        ReproducingFieldTrigger<bool> tg = ReproducingFieldTrigger.disabled();
        expect(tg.access(first), equals(absence));

        tg = ReproducingFieldTrigger(content);
        expect(tg.access(first), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(second), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(first), equals(content));
      });
    });
  });
  group("Boolean", () {
    const absence = false;
    const content = true;

    group("Form", () {
      test('Invalidating', () {
        FormBoolTrigger tg = FormBoolTrigger.disabled();
        expect(tg.accessAsFirst(), equals(absence));

        tg = FormBoolTrigger();
        expect(tg.accessAsFirst(), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst("another"), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst(), equals(absence));

        expect(tg.accessAsSecond(), equals(content));
      });
      test('Reproducing', () {
        ReproducingFormBoolTrigger tg = ReproducingFormBoolTrigger.disabled();
        expect(tg.accessAsFirst(), equals(absence));

        tg = ReproducingFormBoolTrigger();
        expect(tg.accessAsFirst(), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst("another"), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst(), equals(content));

        expect(tg.accessAsSecond(), equals(content));
      });
      test('Disabling', () {
        DisablingFormBoolTrigger tg = DisablingFormBoolTrigger.disabled();
        expect(tg.accessAsFirst(), equals(absence));

        tg = DisablingFormBoolTrigger();
        expect(tg.accessAsFirst(), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.accessAsFirst("another"), equals(absence));
        expect(tg.isDisabled, equals(true));
        expect(tg.accessAsFirst(), equals(absence));

        expect(tg.accessAsSecond(), equals(absence));
      });
    });
    group("Field", () {
      const first = "Value";
      const second = "Value2";

      test('Disabling', () {
        FieldBoolTrigger tg = FieldBoolTrigger.disabled();
        expect(tg.access(first), equals(absence));

        tg = FieldBoolTrigger();
        expect(tg.access(first), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(second), equals(absence));
        expect(tg.isDisabled, equals(true));
        expect(tg.access(first), equals(absence));
      });
      test('Reproducing', () {
        ReproducingFieldBoolTrigger tg = ReproducingFieldBoolTrigger.disabled();
        expect(tg.access(first), equals(absence));

        tg = ReproducingFieldBoolTrigger();
        expect(tg.access(first), equals(content));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(second), equals(absence));
        expect(tg.isDisabled, equals(false));
        expect(tg.access(first), equals(content));
      });
    });
  });
}

extension FormTriggerX<T extends Object> on BaseFormTrigger<T> {
  accessAsFirst([key = 'key']) => access(key, fieldId: "first");
  accessAsSecond([key = 'key']) => access(key, fieldId: "second");
}

extension FormBoolTriggerX on BaseFormBoolTrigger {
  accessAsFirst([key = 'key']) => access(key, fieldId: "first");
  accessAsSecond([key = 'key']) => access(key, fieldId: "second");
}

///dart```
/// 
/// Widget build(BuildContext context)  {
///   final int a;
/// }
///```
