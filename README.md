<p align="center">
<img src="https://raw.githubusercontent.com/AlexandrFarkas/trigger/master/docs/assets/logo_with_name.svg" height="140" alt="Trigger logo" />
</p>

## Trigger

Boilerplate-free form validation library.

# <a>Preface</a>

- [Why?](#why)
  - [Why not Formz?](#why_not_formz)
  - [Why Trigger?](#why_trigger)
- [Getting started](#getting_started)
- [Simple Usage](#simple_usage)
- [Inspiration](#inspiration)

# <a name="why">Why?</a>

There is no clean and nice way to separate business logic (validation) from presentation.

### <a name="why_not_formz">Why not Formz?</a>

Formz defies Flutter's way to handle state, forcing user to hold form state entirely in business logic.

But it can't be done in Flutter. State is inevitably stored in TextEditingControllers. Formatters are applied inside widget itself.

When I use formz, I always find myself copy-pasting form inputs and struggling with simple use cases.

### <a name="why_trigger">Why Trigger?</a>

- Minimalistic.
- Perfectly fits flutter's form handling system.
- Your teammates just need to explore a couple of simple concepts.

# <a name="simple_usage">Simple Usage</a>

**Use case**: We want to validate that email doesn't exist in our database. If it does, display error.
```dart
class LoginFormState extends ChangeNotifier {
  Vf _emailAlreadyExists;

  LoginFormState([
    this._emailAlreadyExists = const VfReproduce.sealed()
  ]);

  String? validateEmail(String? email) {
    if (_emailAlreadyExists.access(email)) {
      return "Email already exists";
    }

    return null;
  }

  Future<void> submit() {
    await Future.delayed(Duration(seconds: 1)); // access the database
    _emailAlreadyExists = Vf();
    notifyListeners();
  }
}
```

Somewhere in Flutter code:

```dart

final loginFormState = LoginFormState();

void initState() {
  super.initState();
  loginFormState.addListener(() => setState(() {}));
}

Widget build(BuildContext context) => Column(
  children: [
    TextFormField(
      validator: loginFormState.validateEmail,
    ),
    OutlinedButton(onPressed: loginFormState.submit),
  ]
);

```

# <a name="inspiration">Inspiration</a>

The whole work was inspired by event concept in [async_redux](https://pub.dev/packages/async_redux), created by [Marcelo Glasberg](https://github.com/marcglasberg).










