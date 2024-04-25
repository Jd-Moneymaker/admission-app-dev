import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/model.dart';
import '../../api/firebase_auth_api.dart';

// ? imports

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseApi _firebaseApi = FirebaseApi();

  // ! email signin function
  void emailSignin(String email, phone, password) async {
    emit(AuthLoadingState());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_firebaseAuth.currentUser != null) {
        emit(AuthLoggedInState(_firebaseAuth.currentUser!));
        // * saves user
        _firebaseApi.saveUser(
          AuthModel(
            uid: FirebaseAuth.instance.currentUser!.uid,
            email: email,
            phoneNumber: phone,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }
  // ! email signin function

  // ! phone signin/signup function
  String? _verificationId;
  Future<void> phoneSignin(String email, password, phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(SigninCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  // * functions. sign in with phone
  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }

  // * functions. verify otp
  void verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }
  // ! phone signin/signup function

  // ! login functions
  void emailLogin(String email, password) async {
    emit(AuthLoadingState());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_firebaseAuth.currentUser != null) {
        emit(AuthLoggedInState(_firebaseAuth.currentUser!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }
  // ! login functions

  // ! logout functions
  void logOut() async {
    emit(LogoutInProgress());
    try {
      FirebaseAuth.instance.signOut();
      emit(AuthLoggedOutState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }
  // ! logout functions
}
