import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Sample3FirebaseUser {
  Sample3FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Sample3FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Sample3FirebaseUser> sample3FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Sample3FirebaseUser>(
        (user) => currentUser = Sample3FirebaseUser(user));
