import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/constants/strings.dart';
import 'package:flutter_assignment/controller/photos_controller.dart';
import 'package:flutter_assignment/model/photos_model.dart';
import 'package:flutter_assignment/networking/api_response.dart';
import 'package:flutter_assignment/networking/widget/loading_widget.dart';
import 'package:flutter_assignment/networking/widget/error_widget.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhotosPageView extends StatelessWidget {
  PhotosPageView({Key? key}) : super(key: key);

  PhotosController photosController = Get.isRegistered<PhotosController>()
      ? Get.find<PhotosController>()
      : Get.put(PhotosController());
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    photosController.fetchPhotosPagination();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.appTitle)),
      body: Obx(() {
        Status status = photosController.apiResponse.value.status;
        switch (status) {
          case Status.LOADING:
            return Loading(
                loadingMessage: photosController.apiResponse.value.message);
          case Status.COMPLETED:
            List<PhotosPOJO> list = photosController.photoList;

            return SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              onLoading: _onLoading,
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, position) {
                    PhotosPOJO photosModel = list[position];
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: InkWell(
                          onTap: () {
                            print('adaasdasdsa');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        height: 250,
                                        width: 250,
                                        imageUrl: photosModel.url ?? '',
                                        placeholder: (context, url) =>
                                            Transform.scale(
                                                scale: 0.3,
                                                child:
                                                    const CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ]),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        //Put your code here which you want to execute on Yes button click.
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: photosModel.thumbnailUrl ?? '',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        title: Text(photosModel.title ?? ''),
                        trailing: InkWell(
                            onTap: () {
                              photosController.updateLike(
                                  position, photosModel);
                            },
                            child: (photosModel.isLiked ?? false)
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border)),
                      ),
                    );
                  }),
            );
          case Status.ERROR:
            return Error(
                errorMessage: photosController.apiResponse.value.message,
                onRetryPressed: () {
                  print('retry tapped');
                  photosController.fetchPhotos();
                });
        }
      }),
    );
  }
}
