import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class db with ChangeNotifier {
  FirebaseAuth? _auth = FirebaseAuth.instance;
  String? verificationId;
  String? errorMessage = '';
  Status _status = Status.Uninitialized;
  db.initialize() {}

  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    print(number);
    try {
      await _auth!.verifyPhoneNumber(
          phoneNumber: "+91" + number.trim(),

          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: (String verId, [int? forceCodeResend]) {
            this.verificationId = verId;
          },
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "lets make this work");
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message} + something is wrong');
          });
      notifyListeners();
    } catch (e) {
      handleError(e);
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  handleError(error) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print("The verification code is invalid");
        break;
      default:
        errorMessage = error.message;
        break;
    }
    notifyListeners();
  }

  Future signOut() async {
    _auth!.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
