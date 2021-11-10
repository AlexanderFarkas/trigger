import 'package:test/scaffolding.dart';
import 'package:test/test.dart';
import 'package:trigger/src/validation_errors.dart';
import 'package:trigger/trigger.dart';
import 'package:trigger/validators.dart';

typedef Pipe<T> = ValidationPipeline<T>;
void main() {
  const validated = null;

  group("min length", () {
    const error = "error";

    test("logic", () {
      expect(Pipe("").minLength(0, error: error)(), equals(validated));
      expect(Pipe("").minLength(1, error: error)(), equals(error));
      expect(Pipe("😑😒").minLength(1, error: error)(), equals(validated));
      expect(Pipe("😑😒").minLength(2, error: error)(), equals(validated));
      expect(Pipe("😑😒").minLength(3, error: error)(), equals(error));
      expect(Pipe("異體字").minLength(2, error: error)(), equals(validated));
      expect(Pipe("異體字").minLength(3, error: error)(), equals(validated));
      expect(Pipe("異體字").minLength(4, error: error)(), equals(error));
      expect(Pipe("help").minLength(3, error: error)(), equals(validated));
      expect(Pipe("help").minLength(4, error: error)(), equals(validated));
      expect(Pipe("help").minLength(5, error: error)(), equals(error));
    });

    test("default errors", () {
      const falseCriteria = 1;
      const value = "";
      expect(
        Pipe(value).minLength(falseCriteria, error: error)(),
        equals(error),
      );
      expect(
        Pipe(value).minLength(falseCriteria)(),
        equals(ValidationErrors.instance.minLength(falseCriteria)),
      );
    });
  });
  group("max length", () {
    const error = "error";

    test("logic", () {
      expect(Pipe("").maxLength(0, error: error)(), equals(validated));
      expect(Pipe("").maxLength(1, error: error)(), equals(validated));
      expect(Pipe("😑😒").maxLength(1, error: error)(), equals(error));
      expect(Pipe("😑😒").maxLength(2, error: error)(), equals(validated));
      expect(Pipe("😑😒").maxLength(3, error: error)(), equals(validated));
      expect(Pipe("異體字").maxLength(2, error: error)(), equals(error));
      expect(Pipe("異體字").maxLength(3, error: error)(), equals(validated));
      expect(Pipe("異體字").maxLength(4, error: error)(), equals(validated));
      expect(Pipe("help").maxLength(3, error: error)(), equals(error));
      expect(Pipe("help").maxLength(4, error: error)(), equals(validated));
      expect(Pipe("help").maxLength(5, error: error)(), equals(validated));
    });

    test("default errors", () {
      const falseCriteria = 0;
      const value = "A";
      expect(
        Pipe(value).maxLength(falseCriteria, error: error)(),
        equals(error),
      );
      expect(
        Pipe(value).maxLength(falseCriteria)(),
        equals(ValidationErrors.instance.maxLength(falseCriteria)),
      );
    });
  });

  test("minmax length", () {
    const errorMin = "errorMin";
    const errorMax = "errorMax";

    expect(
      Pipe("A").maxLength(0, error: errorMax).minLength(2, error: errorMin)(),
      equals(errorMax),
    );
    expect(
      Pipe("A").minLength(2, error: errorMin).maxLength(0, error: errorMax)(),
      equals(errorMin),
    );
  });

  group("email", () {
    test("valid", () {
      final valid = [
        r'simple@example.com',
        r'very.common@example.com',
        r'disposable.style.email.with+symbol@example.com',
        r'other.email-with-hyphen@example.com',
        r'fully-qualified-domain@example.com',
        r'user.name+tag+sorting@example.com',
        r'x@example.com',
        r'example-indeed@strange-example.com',
        r'test/test@test.com',
        r'example@s.example',
        r'"john..doe"@example.org',
        r'mailhost!username@example.org',
        r'user%example.com@example.org',
        r'user-@example.org',
        r'prettyandsimple@example.com',
        r'very.common@example.com',
        r'disposable.style.email.with+symbol@example.com',
        r'other.email-with-dash@example.com',
        r"#!$%&'*+-/=?^_`{}|~@example.org",
        r'üñîçøðé@example.com',
        r'üñîçøðé@üñîçøðé.com',
        r'Pelé@example.com',
        r'δοκιμή@παράδειγμα.δοκιμή',
        r'我買@屋企.香港',
        r'甲斐@黒川.日本',
        r'чебурашка@ящик-с-апельсинами.рф',
        r'рубль@майл.ру',
        r'sup3fd`eqe1_3@майл.ruuuu',
        r'doc@vk.com',
      ];
      for (final v in valid) {
        expect(Pipe(v).isEmail()(), equals(null), reason: v);
      }
    });

    test("invalid", () {
      final invalid = [
        r'plainaddress',
        r'@d.r',
        r'dsd.r',
        r'dfr dsdr@_f.r',
        r'example',
        r'example@',
        r'example@domain',
        r'example@domain.',
        r'example@domain.com ',
      ];
      for (final iv in invalid) {
        expect(Pipe(iv).isEmail()(), equals(ValidationErrors.instance.email()), reason: iv);
      }
    });

    test("default errors", () {
      const value = "A";
      const error = "Email error";
      expect(
        Pipe(value).isEmail(error: error)(),
        equals(error),
      );
      expect(
        Pipe(value).isEmail()(),
        equals(ValidationErrors.instance.email()),
      );
    });
  });

  group("triggers", () {
    final reproduceTrigger = ReproducingFieldTrigger();
    const triggerError = "1";
    expect(
        Pipe("s@.ru").untriggered(reproduceTrigger, errorBuilder: (_) => triggerError).isEmail()(),
        equals(null));
  });
  test("custom", () {
    const error = "error";
    validator(value) => value.length < 3 ? error : null;

    expect(Pipe("A").custom(validator)(), error);
    expect(Pipe("ABC").custom(validator)(), null);
  });
}
