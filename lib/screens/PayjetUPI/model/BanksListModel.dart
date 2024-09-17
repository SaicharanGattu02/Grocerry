class BanksListModel {
  int? bankID;
  String? bANKNAME;
  String? bANKCODE;
  String? iMPSStatus;
  String? nEFTStatus;
  String? vERIFICATION;

  BanksListModel(
      {this.bankID,
        this.bANKNAME,
        this.bANKCODE,
        this.iMPSStatus,
        this.nEFTStatus,
        this.vERIFICATION});

  BanksListModel.fromJson(Map<String, dynamic> json) {
    bankID = json['BankID'];
    bANKNAME = json['BANK_NAME'];
    bANKCODE = json['BANK CODE'];
    iMPSStatus = json['IMPS_Status'];
    nEFTStatus = json['NEFT_Status'];
    vERIFICATION = json['VERIFICATION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BankID'] = this.bankID;
    data['BANK_NAME'] = this.bANKNAME;
    data['BANK CODE'] = this.bANKCODE;
    data['IMPS_Status'] = this.iMPSStatus;
    data['NEFT_Status'] = this.nEFTStatus;
    data['VERIFICATION'] = this.vERIFICATION;
    return data;
  }
}
