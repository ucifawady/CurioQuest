class PostModel {
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.image,
    this.text,
    this.dateTime,
    this.postImage,
  });
  PostModel.fromJson(Map<String , dynamic>json){
    name = json['name'];
    image = json['image'];
    text = json['text'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];

  }
  Map<String , dynamic> toMap(){
    return{
      'name':name,
      'image':image,
      'text':text,
      'dateTime': dateTime,
      'postImage':postImage,
    };
  }
}