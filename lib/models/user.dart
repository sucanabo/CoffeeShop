class UserModel {
  int id;
  String firstName;
  String lastName;
  String image;
  String email;
  String phone;
  String token;
  DateTime birthday;
  String gender;
  bool isEmailVerified;
  int level;
  int point;
  String barCode;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.image,
      this.email,
      this.phone,
      this.birthday,
      this.gender,
      this.isEmailVerified,
      this.token,
      this.level,
      this.point,
      this.barCode});

  //function to convert json data to user model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      image: json['user']['image'],
      email: json['user']['email'],
      isEmailVerified: json['user']['email_verified_at'] != null,
      phone: json['user']['phone'],
      birthday: DateTime.parse(json['user']['birthday']),
      gender: json['user']['gender'],
      level: json['user']['level'],
      point: json['user']['point'],
      barCode: json['user']['bar_code'],
      token: json['token'],
    );
  }
}
