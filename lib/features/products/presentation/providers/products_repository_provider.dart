

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infraestructure/infraestructure.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accesToken = ref.watch(authProvider).user?.token??'';
  final productsRepository = ProductsRepositoryImp(
    ProductsDatasourceImpl(accesToken: accesToken)
  );
  
  return  productsRepository;
},);