import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'firestore_path.dart';

class FirebaseStorageService {
  final String uid;

  FirebaseStorageService({@required this.uid}) : assert(uid != null);

  /// Upload an avatar from file
  Future<String> uploadAvatar({
    @required File file,
  }) async =>
      await upload(
        file: file,
        path: FirestorePath.avatar(uid) + '/avatar.jpg',
        contentType: 'image/jpg',
      );

  /// Generic file upload for any [path] and [contentType]
  Future<String> upload({
    @required File file,
    @required String path,
    @required String contentType,
  }) async {
    print('uploading to: $path');
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final UploadTask uploadTask = storageReference.putFile(
        file, SettableMetadata(contentType: contentType));
    uploadTask
        .then((TaskSnapshot snapshot) => {print('Upload complete')})
        .catchError((Object error) {
      print('upload error code: $error');
    });
    // Url used to download file/image
    final downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    return downloadUrl;
  }
}
