

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuiro_quest_app/models/s.dart';

PostModel? user;
void sendpost({
  required String name, required String image,
  String? text, String? postImage,
  String? dateTime,
}){
  PostModel modell = PostModel(
    name: name,
    image: image,
    text: text,
    dateTime: dateTime,
    postImage: postImage,

  );
  FirebaseFirestore.instance.collection('Main Gallery').add(modell.toMap());

}
List<PostModel>posts = [];
void gets(){
  FirebaseFirestore.instance.collection('Main Gallery').get().then((value){
    value.docs.forEach((element) {
      posts.add(PostModel.fromJson(element.data()));
    }
    );});
}
