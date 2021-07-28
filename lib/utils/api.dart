import 'package:http/http.dart' as http;
import '../config/config.dart';

class Api{
  Future<http.Response> getFish(){
    return http.get(urlFish, headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
  }

  Future<http.Response> getDetailFish(id){
    return http.get(Uri.parse(urlServer+"ikan/"+id+"/"),headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
  }

}