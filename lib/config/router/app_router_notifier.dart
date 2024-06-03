import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

final gorouterNotifierProvider = Provider((ref){
  final authNotifier =  ref.read(authProvider.notifier);
  return GorouterNotifier(authNotifier);
}); 

class GorouterNotifier extends ChangeNotifier{

  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;

  GorouterNotifier(this._authNotifier){
    _authNotifier.addListener((state){
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value){
    _authStatus = value;
    notifyListeners();
  }



}