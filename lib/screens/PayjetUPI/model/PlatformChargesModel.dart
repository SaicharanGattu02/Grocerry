class PlatformChargesModel {
  bool? status;
  double? pfCharges;
  int? actualAmount;
  double? afterPfCharges;

  PlatformChargesModel(
      {this.status, this.pfCharges, this.actualAmount, this.afterPfCharges});

  PlatformChargesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pfCharges = json['pf_charges'];
    actualAmount = json['actual_amount'];
    afterPfCharges = json['after_pf_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['pf_charges'] = this.pfCharges;
    data['actual_amount'] = this.actualAmount;
    data['after_pf_charges'] = this.afterPfCharges;
    return data;
  }
}