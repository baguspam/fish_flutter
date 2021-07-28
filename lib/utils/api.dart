import 'package:http/http.dart' as http;
import '../config/config.dart';

class Api{
  Future<http.Response> getFish(){
    return http.get(urlFish);
  }

  Future<http.Response> getDetailFish(id){
    return http.get(Uri.parse(urlServer+"ikan/"+id+"/"));
  }
}