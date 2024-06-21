class NavyUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  int? avatarIndex;  // Change to int
  bool? isEmailVerified;

  NavyUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.avatarIndex,
    this.isEmailVerified,
  });

  NavyUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    avatarIndex = json['avatarIndex']; // Change to int
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'avatarIndex': avatarIndex, // Change to int
      'isEmailVerified': isEmailVerified,
    };
  }
}