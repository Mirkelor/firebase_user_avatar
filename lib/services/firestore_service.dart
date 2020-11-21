import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_user_avatar/models/avatar_reference.dart';
import 'package:flutter/foundation.dart';

import 'firestore_path.dart';

class FirestoreService {
  final String uid;

  FirestoreService({@required this.uid}) : assert(uid != null);

  Future<void> setAvatarReference({
    @required AvatarReference avatarReference,
  }) async {
    final path = FirestorePath.avatar(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(avatarReference.toMap());
  }

  Stream<AvatarReference> avatarReferenceStream() {
    final path = FirestorePath.avatar(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => AvatarReference.fromMap(snapshot.data()));
  }
}
