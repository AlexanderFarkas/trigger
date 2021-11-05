import 'package:test/test.dart';
import 'package:valform/valform.dart';

void main() {
  group("Typed", () {
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
  VfExpel<T> vf = VfExpel.sealed();
  expect(vf.accessAsFirst(), equals(absence));

  vf = VfExpel(passContentToConstructor ? content : null);
  expect(vf.accessAsFirst(), equals(content));
  expect(vf.accessAsFirst("another"), equals(absence));
  expect(vf.accessAsFirst(), equals(absence));

  expect(vf.accessAsSecond(), equals(content));
}

void reproduceValform<T>({
  required T content,
  required absence,
  required bool passContentToConstructor,
}) {
  VfReproduce<T> vf = VfReproduce.sealed();
  expect(vf.accessAsFirst(), equals(absence));

  vf = VfReproduce(passContentToConstructor ? content : null);
  expect(vf.accessAsFirst(), equals(content));
  expect(vf.accessAsFirst("another"), equals(absence));
  expect(vf.accessAsFirst(), equals(content));

  expect(vf.accessAsSecond(), equals(content));
}

void sealValform<T>({
  required T content,
  required absence,
  required bool passContentToConstructor,
}) {
  VfSeal<T> vf = VfSeal.sealed();
  expect(vf.accessAsFirst(), equals(absence));

  vf = VfSeal(passContentToConstructor ? content : null);
  expect(vf.accessAsFirst(), equals(content));
  expect(vf.accessAsFirst("another"), equals(absence));
  expect(vf.accessAsFirst(), equals(absence));

  expect(vf.accessAsSecond(), equals(absence));
}

extension MultiValformX<T> on MultiValform<T> {
  accessAsFirst([key = 'key']) => access(key, ownerId: "first");
  accessAsSecond([key = 'key']) => access(key, ownerId: "second");
}
