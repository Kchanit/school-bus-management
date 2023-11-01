import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  final image = Rxn<XFile>();
  final imagePath = RxString('');
  final ImagePicker imagePicker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await imagePicker.pickImage(source: media);
    image.value = img;
    imagePath.value = img!.path;
  }

  uploadImage(String path) async {
    // try {
    //   final form = FormData({});
    //   form.files.add(MapEntry(
    //       'image',
    //       await MultipartFile.fromFile(path,
    //           filename:
    //               "${DateTime.now().microsecondsSinceEpoch}.${path.split('.').last}")));
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
