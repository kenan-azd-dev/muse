import 'dart:io';

// 3rd Party Package
import 'package:firebase_storage/firebase_storage.dart';
class FirebaseUtils {
  static Future<String> storeFileToFirebase(String ref, File file) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}