import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:photo_manager/photo_manager.dart';

@RoutePage()
class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  void initState() {
    super.initState();
    _loadAvailableFolder();
  }

  final List<AssetPathEntity> _folder = [];

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _loadIMedia();
      }
    }
  }

  int currentIndexFolder = 0;
  List<AssetEntity> mediaList = [];
  int totalMedia = 0;
  String idFolderSelected = '';
  List<Widget> buildMediaWidget = [];

  int currentPage = 0;
  int? lastPage;

  Future<void> _loadAvailableFolder({String idFolder = ''}) async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> folders = await PhotoManager.getAssetPathList();
      List<AssetPathEntity> finalFolders = [];
      for (var element in folders) {
        int count = await element.assetCountAsync;
        if (count > 0) {
          finalFolders.add(element);
        }
      }
      _folder.clear();
      _folder.addAll(finalFolders);
      int indexFolder = _folder.indexWhere((element) => element.id == idFolder);
      if (indexFolder == -1) {
        currentIndexFolder = 0;
      } else {
        buildMediaWidget.clear();
        currentIndexFolder = indexFolder;
        currentPage = 0;
      }

      idFolderSelected = _folder[currentIndexFolder].id;
      await _loadIMedia();
    } else {
      PhotoManager.openSetting();
    }
  }

  _loadIMedia() async {
    lastPage = currentPage;
    print(lastPage);
    if (_folder.isEmpty) {
      mediaList = [];
      return;
    }
    totalMedia = await _folder[currentIndexFolder].assetCountAsync;

    mediaList = await _folder[currentIndexFolder]
        .getAssetListPaged(page: 0, size: totalMedia);

    List<Widget> temp = [];
    for (var asset in mediaList) {
      temp.add(
        FutureBuilder(
          future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (asset.type == AssetType.video)
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5, bottom: 5),
                        child: Icon(
                          Icons.videocam,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              );
            }
            return Container();
          },
        ),
      );
    }
    setState(() {
      buildMediaWidget.addAll(temp);
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_folder.isNotEmpty)
              SizedBox(
                height: 60,
                child: DropdownButton(
                  alignment: Alignment.center,
                  value: idFolderSelected,
                  items: _folder
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.name,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newId) {
                    debugPrint(newId.toString());
                    setState(() {
                      idFolderSelected = newId ?? '';
                      _loadAvailableFolder(idFolder: newId ?? '');
                    });
                  },
                ),
              ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scroll) {
                  debugPrint('scroll');
                  // _handleScrollEvent(scroll);
                  return false;
                },
                child: GridView.builder(
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  shrinkWrap: true,
                  itemCount: mediaList.length,
                  itemBuilder: (context, index) {
                    return buildMediaWidget[index];
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
