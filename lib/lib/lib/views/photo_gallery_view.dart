import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_photo_cloud_app/lib/bloc/app_bloc.dart';
import 'package:main_photo_cloud_app/lib/bloc/app_event.dart';
import 'package:main_photo_cloud_app/lib/bloc/app_state.dart';
import 'package:main_photo_cloud_app/lib/lib/views/main_popup_menu_button.dart';
import 'package:main_photo_cloud_app/lib/lib/views/storage_images_view.dart';

class PhotoGalleryView extends HookWidget {
  const PhotoGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final images = context.watch<Appbloc>().state.images ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image == null) {
                return;
              }
              context.read<Appbloc>().add(
                    AppEventUploadImage(
                      filePathToUpload: image.path,
                    ),
                  );
            },
            icon: const Icon(
              Icons.upload,
            ),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children:
          images.map(
            (img) => StorageImageView(
              image: img,
            ),
          ).toList(),
      ),
    );
  }
}
