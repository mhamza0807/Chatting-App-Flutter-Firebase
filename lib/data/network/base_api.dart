
abstract class BaseApi {

  Future<dynamic> getApi(String url);

  Future<dynamic> postApi(String url, var data);

}