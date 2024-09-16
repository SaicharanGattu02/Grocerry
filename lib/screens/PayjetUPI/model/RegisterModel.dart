class RegisterModel {
  String? message;
  User? user;
  bool? status;

  RegisterModel({this.message, this.user, this.status});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? mobile;
  bool? mobileVerified;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? profilePictureUrl;

  User(
      {this.name,
        this.email,
        this.mobile,
        this.mobileVerified,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.profilePictureUrl});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    mobileVerified = json['mobile_verified'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    profilePictureUrl = json['profile_picture_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['mobile_verified'] = this.mobileVerified;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['profile_picture_url'] = this.profilePictureUrl;
    return data;
  }
}
