import 'package:shared_preferences/shared_preferences.dart';

enum SignupHead {
  email,
  phone,
}

class SignupData {
  final SignupHead head;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? password;
  final bool? termsAgreed;

  const SignupData({
    required this.head,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.termsAgreed,
  });

  copy(
    {
      String? email,
      String? phone,
      String? firstName,
      String? lastName,
      String? password,
      bool? termsAgreed,
    }
  ) {
    return SignupData(
        head: head,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password,
        termsAgreed: termsAgreed ?? this.termsAgreed
    );
  }
}

Future<SignupData> retrieveFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final SignupHead signupHead;
  final int? cachedSignupHead = prefs.getInt('head');
  if(cachedSignupHead == null) {
    signupHead = SignupHead.email;
  } else if(cachedSignupHead >= SignupHead.values.length) {
    signupHead = SignupHead.email;
  } else {
    signupHead = SignupHead.values[cachedSignupHead];
  }
  return Future.value(
      SignupData(
        head: signupHead,
        email: prefs.getString('email') ?? '',
        phone: prefs.getString('phone') ?? '',
        firstName: prefs.getString('firstName') ?? '',
        lastName: prefs.getString('lastName') ?? '',
        password: prefs.getString('password') ?? '', // TODO Security Issue
        termsAgreed: prefs.getBool('termsAgreed') ?? false,
      )
  );
}

Future<void> clearFromStorage(Function() done) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('head');
  await prefs.remove('email');
  await prefs.remove('phone');
  await prefs.remove('firstName');
  await prefs.remove('lastName');
  await prefs.remove('password');
  await prefs.remove('termsAgreed');
  done();
}

Future<void> saveOnStorage(SignupData data, Function() done) async {
  final prefs = await SharedPreferences.getInstance();
  final headIndex = SignupHead.values.indexOf(data.head);
  if(headIndex == -1) {
    prefs.setInt('head', 0);
  } else {
    prefs.setInt('head', headIndex);
  }
  await prefs.setString('email', data.email ?? "");
  await prefs.setString('phone', data.phone ?? "");
  await prefs.setString('firstName', data.firstName ?? "");
  await prefs.setString('lastName', data.lastName ?? "");
  await prefs.setString('password', data.password ?? "");
  await prefs.setBool('termsAgreed', data.termsAgreed ?? false);
  done();
}