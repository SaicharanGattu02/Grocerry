class LogInModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  User? user;

  LogInModel({this.accessToken, this.tokenType, this.expiresIn, this.user});

  LogInModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  int? mobile;
  Null? emailVerifiedAt;
  int? mobileVerified;
  Null? userType;
  String? profilePicture;
  Null? shopname;
  Null? dob;
  Null? address;
  Null? state;
  Null? city;
  Null? zip;
  Null? whatsappnumber;
  Null? aadhar;
  Null? pan;
  String? pinNum;
  String? createdAt;
  String? updatedAt;
  String? profilePictureUrl;

  User(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.emailVerifiedAt,
        this.mobileVerified,
        this.userType,
        this.profilePicture,
        this.shopname,
        this.dob,
        this.address,
        this.state,
        this.city,
        this.zip,
        this.whatsappnumber,
        this.aadhar,
        this.pan,
        this.pinNum,
        this.createdAt,
        this.updatedAt,
        this.profilePictureUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    mobileVerified = json['mobile_verified'];
    userType = json['user_type'];
    profilePicture = json['profile_picture'];
    shopname = json['shopname'];
    dob = json['dob'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    zip = json['zip'];
    whatsappnumber = json['whatsappnumber'];
    aadhar = json['aadhar'];
    pan = json['pan'];
    pinNum = json['pin_num'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePictureUrl = json['profile_picture_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile_verified'] = this.mobileVerified;
    data['user_type'] = this.userType;
    data['profile_picture'] = this.profilePicture;
    data['shopname'] = this.shopname;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['whatsappnumber'] = this.whatsappnumber;
    data['aadhar'] = this.aadhar;
    data['pan'] = this.pan;
    data['pin_num'] = this.pinNum;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_picture_url'] = this.profilePictureUrl;
    return data;
  }
}
