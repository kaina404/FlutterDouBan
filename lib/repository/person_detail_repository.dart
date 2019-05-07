import 'package:doubanapp/bean/celebrity_entity.dart';
import 'package:doubanapp/bean/celebrity_work_entity.dart';
import 'package:doubanapp/http/http_request.dart';
import 'package:doubanapp/http/API.dart';

class PersonDetailRepository {
  CelebrityEntity celebrityEntity;
  CelebrityWorkEntity celebrityWorkEntity;
  HttpRequest _httpRequest = HttpRequest(API.BASE_URL);
  PersonDetailRepository({this.celebrityEntity, this.celebrityWorkEntity});

  Future<PersonDetailRepository> requestAPI(String id) async {
    var result = await _httpRequest.get('/v2/movie/celebrity/$id/works?apikey=0b2bdeda43b5688921839c8ecb20399b');
    celebrityWorkEntity = CelebrityWorkEntity.fromJson(result);

    result = await _httpRequest.get('/v2/movie/celebrity/$id?apikey=0b2bdeda43b5688921839c8ecb20399b');
    celebrityEntity = CelebrityEntity.fromJson(result);
    return PersonDetailRepository(celebrityEntity: celebrityEntity, celebrityWorkEntity: celebrityWorkEntity);
  }
}
