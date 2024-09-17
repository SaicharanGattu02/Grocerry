class BannersModel {
  bool? status;
  List<Data>? data;

  BannersModel({this.status, this.data});

  BannersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? banner;
  String? url;
  String? purpose;
  int? settings;
  int? displayStatus;
  String? createdAt;
  String? fullUrl;
  String? urlWithKey;

  Data(
      {this.id,
        this.banner,
        this.url,
        this.purpose,
        this.settings,
        this.displayStatus,
        this.createdAt,
        this.fullUrl,
        this.urlWithKey});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    url = json['url'];
    purpose = json['purpose'];
    settings = json['settings'];
    displayStatus = json['display_status'];
    createdAt = json['created_at'];
    fullUrl = json['full_url'];
    urlWithKey = json['url_with_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['url'] = this.url;
    data['purpose'] = this.purpose;
    data['settings'] = this.settings;
    data['display_status'] = this.displayStatus;
    data['created_at'] = this.createdAt;
    data['full_url'] = this.fullUrl;
    data['url_with_key'] = this.urlWithKey;
    return data;
  }
}
