import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final _uuid = const Uuid();

  Future<String> uploadFile(File file, String path) async {
    try {
      final fileName = "${DateTime.now().microsecondsSinceEpoch}_${_uuid.v4()}.jpg";
      final ref = _storage.ref().child('$path/$fileName');
      final compressedFile = await _compressImage(file);
      final task = await ref.putFile(compressedFile);
      return await task.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }


  Future<List<String>> uploadMultipleFiles(List<File> files, String path) async {
    List<Future<String>> uploads = files.map((file) => uploadFile(file, path)).toList();
    return await Future.wait(uploads);
  }


  Future<File> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.path}/${basename(file.path)}_compressed.jpg';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 70,
    );
    return File(result!.path);
  }

}