class GetOperaterModel {
  List<Data>? data;

  GetOperaterModel({this.data});

  GetOperaterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? operatorId;
  String? name;
  int? billFetchResponse;
  int? highCommissionChannel;
  int? kycRequired;
  int? operatorCategory;
  int? locationId;

  Data(
      {this.operatorId,
        this.name,
        this.billFetchResponse,
        this.highCommissionChannel,
        this.kycRequired,
        this.operatorCategory,
        this.locationId});

  Data.fromJson(Map<String, dynamic> json) {
    operatorId = json['operator_id'];
    name = json['name'];
    billFetchResponse = json['billFetchResponse'];
    highCommissionChannel = json['high_commission_channel'];
    kycRequired = json['kyc_required'];
    operatorCategory = json['operator_category'];
    locationId = json['location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operator_id'] = this.operatorId;
    data['name'] = this.name;
    data['billFetchResponse'] = this.billFetchResponse;
    data['high_commission_channel'] = this.highCommissionChannel;
    data['kyc_required'] = this.kycRequired;
    data['operator_category'] = this.operatorCategory;
    data['location_id'] = this.locationId;
    return data;
  }
}
