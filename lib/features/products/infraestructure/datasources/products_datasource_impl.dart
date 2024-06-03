

import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';

import '../../domain/domain.dart';
import '../mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource{
  late final Dio dio;
  final String accesToken;

  ProductsDatasourceImpl({
    required this.accesToken
    }) : dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accesToken'
                })
    );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById({String? id}) {
    // TODO: implement getProductById 
    //TODO: SACAR EL ?
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) async{
    final response = await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for (final product in response.data??[]){
      products.add(ProductMapper.jsonToEntity(product));
    }
    return products;
  }

  @override
  Future<List<Product>> getProductsByTerm(String term) {
    // TODO: implement getProductsByTerm
    throw UnimplementedError();
  }

}