import 'package:dars_55_home/data/models/error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestFirebaseServices {
  final _authGet = FirebaseAuth.instance;

  Future<ErrorType?> createUser(String email, String password) async {
    try {
      final response = await _authGet.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ErrorType(isError: false, status: 'null');
    } catch (e) {
      if (e.toString().contains("already")) {
        return ErrorType(isError: true, status: 'already');
      } else if (e.toString().contains("invalid")) {
        return ErrorType(isError: true, status: 'invalid');
      }
    }
  }

  Future<ErrorType?> inUser(String email, String password) async {
    try {
      final response = await _authGet.signInWithEmailAndPassword(
          email: email, password: password);
      return ErrorType(isError: false, status: 'null');
    } catch (e) {
      if (e.toString().contains("invalid")) {
        return ErrorType(isError: true, status: "invalid");
      } else if (e.toString().contains("already")) {
        return ErrorType(isError: true, status: 'already');
      }
    }
  }

}
