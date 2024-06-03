import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductsRepositoryImp extends ProductsRepository{
  final ProductsDatasource datasource;

  ProductsRepositoryImp(this.datasource);
  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return datasource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById({String? id}) {
    return datasource.getProductById(id: id!);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> getProductsByTerm(String term) {
    return datasource.getProductsByTerm(term);
  }

}