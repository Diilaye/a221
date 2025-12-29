import 'dart:convert';
import 'dart:typed_data';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

// ignore: invalid_use_of_visible_for_testing_member
Future getImage(int source) async => ImagePicker.platform
        // ignore: deprecated_member_use
        .getImage(imageQuality: 15, source: ImageSource.gallery)
        .then((value) async {
      if (value == null) {
        return [null, null];
      }
      return [await postpIC(image: value), await value.readAsBytes()];
    });
// ignore: invalid_use_of_visible_for_testing_member
Future getImageUpdate(int source, img) async => ImagePicker.platform
        // ignore: deprecated_member_use
        .getImage(imageQuality: 15, source: ImageSource.gallery)
        .then((value) async {
      if (value == null) {
        return [img.id, BASE_URL_ASSET + img.url!];
      }
      return [await postpIC(image: value), await value.readAsBytes()];
    });

Future<String> postpIC({required XFile image}) async {
  var img = await (image).readAsBytes();

  // Générer un nom de fichier unique avec timestamp
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String originalName = image.name.split("scaled_").last.split(".")[0];
  String uniqueFileName = "${originalName}_$timestamp";
  
  print("image name: $uniqueFileName");
  
  Map<String, dynamic> body = {
    "image":
        "data:$uniqueFileName?image/webp;base64,${base64Encode(img)}"
  };

  var response = await postResponse(url: '/files', body: body);

  if (response['status'] == 200) {
    return response['body']['data']['id'];
  } else {
    return "0";
  }
}

Future getFile() async => FilePicker.platform.pickFiles().then((result) async {
      print("getFile");
      print(result);

      if (result == null) {
        print("here we go");
        return [null, null];
      }
      PlatformFile file = result.files.first;

      print(result.files.first.bytes);

      // Check if path is available
      XFile xfile;
      if (file.path != null) {
        xfile = XFile(file.path!);
      } else {
        xfile = XFile.fromData(file.bytes!, name: file.name);
      }

      final String imageId = await postpIC(image: xfile);
      final Uint8List fileBytes = await xfile.readAsBytes();

      return [imageId, fileBytes];
    });
