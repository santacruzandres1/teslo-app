import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infraestructure/repositorires/auth_repository_impl.dart';
import 'package:teslo_shop/features/shared/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/services/key_value_storage_servie_imp.dart';

import '../../domain/domain.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref){
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageServices = KeyValueStorageServieImp();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageServices: keyValueStorageServices,
    );
});

class AuthNotifier extends StateNotifier<AuthState>{
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageServices;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageServices
    }): super(AuthState()){
    checkAuthStatus();
    }
  Future <void> loginUser(String email, String password) async{
    await Future.delayed(const Duration(milliseconds: 500));
    try {
          final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    }on CustomError catch (e){
      logout(e.message);
    } catch(e){
      logout('Error no controlado');

    }
    // final user = await authRepository.login(email, password);
    // state =  state.copyWith(
    //   user: user,
    //   authStatus: AuthStatus.authenticated,
    // );
  }
    void registerUser(String email, String password) async{
    
  }
    void checkAuthStatus() async{
    final token = await keyValueStorageServices.getValue<String>('token');
    if( token == null ) return logout();
    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }
  
  void _setLoggedUser(User user) async{
    await keyValueStorageServices.setKeyValue('token', user.token);
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: ''
    );
  }

  Future<void> logout([String? errorMessage]) async{
      await keyValueStorageServices.removeKey('token');
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});
  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
