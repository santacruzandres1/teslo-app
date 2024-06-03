import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/products.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {
  final gorouterNotifier =  ref.watch(gorouterNotifierProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: gorouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreeen(),
      ),
      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
    ],
    redirect: (context, state){
      final isGoingTo = state.subloc;
      final authStatus = gorouterNotifier.authStatus;

      if( isGoingTo == 'splash' && authStatus ==AuthStatus.checking ) return null;
      if( authStatus == AuthStatus.notAuthenticated){
        if( isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      } 

      if ( authStatus == AuthStatus.authenticated){
        if( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash') return '/';
      }
      
      return null;
    }
  );
});
