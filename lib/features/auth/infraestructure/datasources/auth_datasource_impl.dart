
import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';

import '../../domain/domain.dart';
import '../errors/auth_errors.dart';
import '../mappers/user_mapper.dart';


class AuthDatasourceImpl extends AuthDatasource{
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  ); //esto se puede optimizar creando un patron adaptador para envolver dio y solo usar ese patron y nos de la ventaja de poder cambiar por http sin

  @override
  Future<User> checkAuthStatus(String token) {
    throw UnimplementedError();
    
  }

  @override
  Future<User> login(String email, String password) async{
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioError catch (e) {
      print(e);
      throw UnimplementedError;
    } catch (e){
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  } 

}