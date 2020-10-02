import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AuthRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getUser() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser;
  }

  Future<bool> isFirstTime(String userId) async {
    bool exist;
    await _db.collection('users').doc(userId).get().then((user) {
      exist = user.exists;
    });

    return exist;
  }

  Future storeUser(user) async {
    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': user.displayName,
      'email': user.email,
    });
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);

    final User user = authResult.user;
    return user;
  }

  Future<void> logOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
