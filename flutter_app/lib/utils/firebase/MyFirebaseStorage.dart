import 'package:firebase_storage/firebase_storage.dart';

class MyFirebaseStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getUrlImage(String imagePath) async{
    final ref = _storage.ref().child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

}