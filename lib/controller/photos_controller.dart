import 'package:flutter_assignment/constants/strings.dart';
import 'package:flutter_assignment/model/photos_model.dart';
import 'package:flutter_assignment/networking/api_response.dart';
import 'package:flutter_assignment/networking/repository.dart';
import 'package:flutter_assignment/utils/storage_util.dart';
import 'package:get/get.dart';

class PhotosController extends GetxController {
  Repository repository = Repository();

  Rx<APIResponse> apiResponse =
      Rx<APIResponse>(APIResponse.loading(Strings.progressMessage));

  RxList<PhotosPOJO> photoList = RxList();
  RxInt page = RxInt(1);

  @override
  void onInit() {
    // TODO: implement onInit
    fetchPhotos();
    super.onInit();
  }

  fetchPhotos() async {
    apiResponse.value = APIResponse.loading(Strings.gettingPhotos);
    try {
      List<PhotosPOJO> photosModel = await repository.getPhotos(page.value);
      print('controller::: ' + photosModel.length.toString());
      apiResponse.value = APIResponse.completed(photosModel);
      List<PhotosPOJO> dummyList = photosModel;
      for (var i = 0; i < dummyList.length; i++) {
        bool getValue = StorageUtil.getBoolean(dummyList[i].id.toString());
        dummyList[i].isLiked = getValue;
      }
      photoList = dummyList.obs;
    } catch (e) {
      apiResponse.value = APIResponse.error(e.toString());

      print(e);
    }
  }

  fetchPhotosPagination() async {
    page++;
    try {
      List<PhotosPOJO> photosModel = await repository.getPhotos(page.value);
      print('controller::: ' + photosModel.length.toString());
      List<PhotosPOJO> dummyList = photosModel;
      for (var i = 0; i < dummyList.length; i++) {
        bool getValue = StorageUtil.getBoolean(dummyList[i].id.toString());
        dummyList[i].isLiked = getValue;
      }
      photoList.addAll(dummyList);
    } catch (e) {
      print(e);
    }
  }

  updateLike(int pos, PhotosPOJO photosPOJO) {
    bool isLiked = photosPOJO.isLiked ?? false;
    photosPOJO.isLiked = isLiked ? false : true;
    photoList[pos] = photosPOJO;
    StorageUtil.putBoolean(
        photosPOJO.id.toString(), photosPOJO.isLiked ?? false);
    print(StorageUtil.getBoolean(photosPOJO.id.toString()));
  }
}
