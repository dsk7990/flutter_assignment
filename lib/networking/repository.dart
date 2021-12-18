import 'package:flutter_assignment/model/photos_model.dart';
import 'package:flutter_assignment/networking/url_constants.dart';

import 'api_provider.dart';

class Repository {
  final ApiProvider _provider = ApiProvider();

  Future<List<PhotosPOJO>> getPhotos(int page) async {
    final response = await _provider.get(UrlConstants.photos + '?_page=$page');
    List<PhotosPOJO> photos =
        (response as List).map((i) => PhotosPOJO.fromJson(i)).toList();
    return photos;
  }
}
