import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileProvider extends ChangeNotifier {
  User? _user;

  ProfileProvider(this._user);

  User? get user => _user;

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  Future<void> updateProfileImage() async {

    notifyListeners();
  }

  Future<void> updateProfile({String? displayName, String? phoneNumber}) async {
    try {
      if (_user != null) {
        if (displayName != null && displayName.isNotEmpty) {
          await _user!.updateDisplayName(displayName);
        }

        _user = FirebaseAuth.instance.currentUser;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }
}
