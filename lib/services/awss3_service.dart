import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AWSS3Service {
  Future<String?> uploadImageToS3(File imageFile, String noteId) async {
    final fileName = imageFile.path.split('/').last;
    final url = Uri.parse(
      "https://filesapisample.stackmod.info/api/presigned-url",
    );

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"noteId": noteId, "fileName": fileName}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final uploadUrl = data['url'];
        final fileUrl = data['uploadedFilePath'];

        if (uploadUrl == null || fileUrl == null) {
          print('Error: Missing uploadUrl or fileUrl');
          return null;
        }

        final uploadRes = await http.put(
          Uri.parse(uploadUrl),
          headers: {"Content-Type": "image/jpeg"},
          body: imageFile.readAsBytesSync(),
        );

        if (uploadRes.statusCode == 200) {
          print('Image uploaded successfully!');
          return fileUrl; 
        } else {
          print('Upload failed: ${uploadRes.body}');
          return null;
        }
      } else {
        print('Failed to get pre-signed URL: ${response.body}');
        return null;
      }
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }


  Future<bool> deleteImageFromS3(String fileUrl) async {
    final url = Uri.parse(
      "https://filesapisample.stackmod.info/api/delete-file",
    );

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"fileUrl": fileUrl}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          print('Image deleted successfully!');
          return true;
        } else {
          print('Failed to delete image: ${data['message']}');
          return false;
        }
      } else {
        print('Failed to get delete URL: ${response.body}');
        return false;
      }
    } catch (e) {
      print("Error deleting image: $e");
      return false;
    }
  }
}
