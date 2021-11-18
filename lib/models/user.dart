class UserModel {
  int id;
  String displayName;
  String image;
  String email;
  String phone;
  String token;
  DateTime birthday;
  String gender;
  bool isEmailVerified;
  int level;
  int point;
  int totalPoint;
  String barCode;

  UserModel(
      {this.id,
      this.displayName,
      this.image,
      this.email,
      this.phone,
      this.birthday,
      this.gender,
      this.isEmailVerified,
      this.token,
      this.level,
      this.point,
      this.totalPoint,
      this.barCode});

  //function to convert json data to user model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      displayName: json['user']['display_name'],
      gender: json['user']['gender'],
      image: json['user']['image'],
      level: json['user']['level'],
      point: json['user']['point'],
      totalPoint: json['user']['total_point'],
      barCode: json['user']['bar_code'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      isEmailVerified: json['user']['email_verified_at'] != null,
      birthday: DateTime.parse(json['user']['birthday']),
      token: json['token'],
    );
  }
}
