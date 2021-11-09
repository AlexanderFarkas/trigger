import 'package:test/test.dart';
import 'package:trigger/src/trigger/base_form_trigger.dart';
import 'package:trigger/trigger.dart';

void main() {
  group("Typed", () {
    test('Single Seal Valform', () => runTyped);
    test('Expelling Valform', () => runTyped(expellingValform));
    test('Reproduce Valform', () => runTyped(reproduceValform));
    test('Seal Valform', () => runTyped(sealValform));
  });

  group("Dynamic", () {
    test('Expelling Valform', () => runDynamic(expellingValform));
    test('Reproduce Valform', () => runDynamic(reproduceValform));
    test('Seal Valform', () => runDynamic(sealValform));
  });
}

typedef ValformTest = void Function<T>(
    {required T content, required dynamic absence, required bool passContentToConstructor});

void runTyped(ValformTest testedValform) =>
    testedValform(content: "Error", absence: null, passContentToConstructor: true);
void runDynamic(ValformTest testedValform) =>
    testedValform<dynamic>(content: true, absence: false, passContentToConstructor: false);

void expellingValform<T>({
  required T content,
  required absence,
  required bool passContentToConstructor,
}) {
  InvalidatingFormTrigger<T> vf = InvalidatingFormTrigger.disabled();
  expect(vf.accessAsFirst(), equals(absence));

  vf = InvalidatingFormTrigger(passContentToConstructor ? content : null);
  expect(vf.accessAsFirst(), equals(content));
  expect(vf.isDisabled, equals(false));
  expect(vf.accessAsFirst("another"), equals(absence));
  expect(vf.isDisabled, equals(false));
  expect(vf.accessAsFirst(), equals(absence));

  expect(vf.accessAsSecond(), equals(content));
}

void reproduceValform<T>({
  required T content,
  required absence,
  required bool passContentToConstructor,
}) {
  ReproducingFormTrigger<T> vf = ReproducingFormTrigger.sealed();
  expect(vf.accessAsFirst(), equals(absence));

  vf = ReproducingFormTrigger(passContentToConstructor ? content : null);
  expect(vf.accessAsFirst(), equals(content));
  expect(vf.isDisabled, equals(false));
  expect(vf.accessAsFirst("another"), equals(absence));
  expect(vf.isDisabled, equals(false));
  expect(vf.accessAsFirst(), equals(content));

  expect(vf.accessAsSecond(), equals(content));
}

void sealValform<T>({
  required T content,
  required absence,
  required bool passContentToConstructor,
}) {
  DisablingFormTrigger<T> vf = DisablingFormTrigger.disabled();
  expect(vf.accessAsFirst(), equals(absence));

  vf = DisablingFormTrigger(passContentToConstructor ? content : null);
  expect(vf.accessAsFirst(), equals(content));
  expect(vf.isDisabled, equals(false));
  expect(vf.accessAsFirst("another"), equals(absence));
  expect(vf.isDisabled, equals(false));
  expect(vf.accessAsFirst(), equals(absence));

  expect(vf.accessAsSecond(), equals(absence));

}

void vf<T>({
  required T content,
  required absence,
  required bool passContentToConstructor,
}) {
  FieldTrigger<T> vf = FieldTrigger.disabled();
  expect(vf.access("Help"), equals(absence));

  vf = FieldTrigger(passContentToConstructor ? content : null);
  expect(vf.access("Help"), equals(content));
  expect(vf.isDisabled, equals(false));
  expect(vf.access("key"), equals(absence));
  expect(vf.isDisabled, equals(true));
}


extension MultiValformX<T> on BaseFormTrigger<T> {
  accessAsFirst([key = 'key']) => access(key, fieldId: "first");
  accessAsSecond([key = 'key']) => access(key, fieldId: "second");
}
