class BanksListModel {
  int? bankID;
  String? bANKNAME;
  String? bANKCODE;
  String? iMPSStatus;
  String? nEFTStatus;
  String? vERIFICATION;

  BanksListModel({
    this.bankID,
    this.bANKNAME,
    this.bANKCODE,
    this.iMPSStatus,
    this.nEFTStatus,
    this.vERIFICATION,
  });

  BanksListModel.fromJson(Map<String, dynamic> json) {
    bankID = json['BankID'];
    bANKNAME = json['BANK_NAME'];
    bANKCODE = json['BANK CODE'];
    iMPSStatus = json['IMPS_Status'];
    nEFTStatus = json['NEFT_Status'];
    vERIFICATION = json['VERIFICATION'];
  }

  Map<String, dynamic> toJson() {
    return {
      'BankID': bankID,
      'BANK_NAME': bANKNAME,
      'BANK CODE': bANKCODE,
      'IMPS_Status': iMPSStatus,
      'NEFT_Status': nEFTStatus,
      'VERIFICATION': vERIFICATION,
    };
  }
}