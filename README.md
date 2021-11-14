<p align="center">
<img src="https://raw.githubusercontent.com/AlexanderFarkas/trigger/master/docs/assets/logo_with_name.svg" height="140" alt="Trigger logo" />
</p>

## Trigger

Boilerplate-free form validation library.

# <a>Preface</a>

- [Why?](#why)
- [Simple Usage](#simple_usage)
- [Getting started](#getting_started)
- [Trigger types](#trigger_types)
  - []
- [Inspiration](#inspiration)

# <a name="why">Why?</a>

- Minimalistic.
- Perfectly fits flutter's form handling system.
- Your teammates just need to explore a couple of simple concepts.

# <a name="simple_usage">Simple Usage</a>

**Use case**: We want to validate that email doesn't exist in our database. If it does, display error.

```dart
class SignUpFormState extends ChangeNotifier with ValidationMixin {
  FieldBoolTrigger _email;

  SignUpFormState([
    this._emailAlreadyExistsTg = const FieldBoolTrigger.disabled()
  ]);

  String? validateEmail(String? email) {
    return validate(email)
      .isValidatedByBool(_emailAlreadyExistsTg)
      .isEmail()();
  }

  Future<void> submit() {
    await Future.delayed(Duration(seconds: 1)); // access the database

    // suppose, that we checked email presence, and there is user with this email already
    _emailAlreadyExistsTg = FieldBoolTrigger();
    notifyListeners();
  }
}
```

Somewhere in Flutter code:

```dart

final signUpFormState = SignUpFormState();

void initState() {
  super.initState();
  signUpFormState.addListener(() => setState(() {}));
}

Widget build(BuildContext context) => Column(
  children: [
    TextFormField(
      validator: signUpFormState.validateEmail,
    ),
    OutlinedButton(onPressed: signUpFormState.submit),
  ]
);

```

# <a name="getting_started">Getting Started</a>

Trigger ships several different types of triggers.
The most used ones - [FieldTrigger](#field_trigger) and [FieldBoolTrigger](#field_bool_trigger)

When `trigger.isDisabled == true`, it always validates value it receives.

Example:

```dart
class State with ValidationMixin {
  FieldBoolTrigger emailAlreadyExists = const FieldBoolTrigger.disabled();

  String? validateEmail(String? email) {
    return validate(email) // comes from ValidationMixin
      .isValidatedByBool(emailAlreadyExists, error: "Already exists")()
  }
}
```

```dart
final state = State();
state.validateEmail("example@mail.com")
>>> null // always, because emailAlreadyExists is disabled
```

If we reassign emailAlreadyExists somewhere like this
`emailAlreadyExists = FieldBoolTrigger();`

then:

```dart
final state = State();
state.validateEmail("example@mail.com")
>>> "Already exists" // Because we 'triggered' emailAlreadyExists and transitioned it to 'enabled' state.
```

If we validate another value within same state, it will be considered valid

```dart
state.validateEmail("anotherexample@mail.com")
>>> null // Trigger only invalidates the first value it receives after becoming enabled
```

# <a name="trigger_types">Trigger Types</a>

## <a>Difference between `*BoolTrigger` and `*Trigger`</a>

`*BoolTrigger` is a special case of `Trigger`.

Let's compare `FieldBoolTrigger` and `FieldTrigger`.

### Instantiation

`FieldBoolTrigger`: <br>

```dart
FieldBoolTrigger enabledTrigger = FieldBoolTrigger();
FieldBoolTrigger disabledTrigger = FieldBoolTrigger.disabled();
```

`FieldTrigger`: <br>

```dart
FieldTrigger<String> enabledTrigger = FieldTrigger("API error from server");
FieldTrigger<String> disabledTrigger = FieldTrigger.disabled();
```

### Validation

`FieldBoolTrigger`: <br>

```dart
class State with ValidationMixin {
  FieldBoolTrigger enabledTrigger = FieldBoolTrigger();

  String? validateEmail(String? email) {
    return validate(email).isValidatedByBool(
      enabledTrigger,
      error: "Not validated",
    )();
  }
}
```

`FieldTrigger`: <br>

```dart
class State with ValidationMixin {
  FieldTrigger<String> enabledTrigger = FieldTrigger("API error from server");

  String? validateEmail(String? email) {
    return validate(email).isValidatedBy(
      enabledTrigger,
      errorBuilder: (content) => "Not validated, error: $content",
    )();
  }
}
```

Actually the `FieldBoolTrigger` behavior can be achieved with `FieldTrigger<bool>`, but in this case you have to always provide `true` to enabled constructor

```dart
FieldTrigger<bool> trigger = FieldTrigger(true);
```


# <a name="inspiration">Inspiration</a>

The whole work was inspired by event concept in [async_redux](https://pub.dev/packages/async_redux), created by [Marcelo Glasberg](https://github.com/marcglasberg).
