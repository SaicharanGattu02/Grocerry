import 'package:egrocer/screens/PayjetUPI/services/userapi.dart';
import '../../helper/utils/generalImports.dart';
import 'model/BanksListModel.dart';


class Moneytransfer extends StatefulWidget {
  @override
  _MoneytransferState createState() => _MoneytransferState();
}

class _MoneytransferState extends State<Moneytransfer> {
  final _formKey = GlobalKey<FormState>();
  bool isNEFTChecked = false;
  bool isIMPSChecked = false;
  String? selectedBeneficiaryType;

  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController accountHolderNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController senderNameController = TextEditingController();

  final List<String> banks = ['Bank A', 'Bank B', 'Bank C'];
  final List<String> beneficiaryTypes = ['Savings', 'Current'];

  @override
  void initState() {
    GetBanksList();
    super.initState();
  }

  BanksListModel? selectedBank;
  List<BanksListModel> bankslist=[];

  Future<void> GetBanksList() async {
    final response = await Userapi.GetBanksListApi();
    if (response != null) {
      setState(() {
        bankslist = response;
        if (bankslist.isNotEmpty) {
          selectedBank = bankslist.first;
        }
      });
    }
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? _validateAccountNumber(String? value) {
    final error = _validateNotEmpty(value);
    if (error != null) return error;
    if (value!.length < 10) {
      return 'Account number must be at least 10 digits';
    }
    return null;
  }

  String? _validateIFSCCode(String? value) {
    final error = _validateNotEmpty(value);
    if (error != null) return error;
    if (value!.length != 11) {
      return 'IFSC code must be 11 characters';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    final error = _validateNotEmpty(value);
    if (error != null) return error;
    if (double.tryParse(value!) == null) {
      return 'Please enter a valid amount';
    }
    if (double.parse(value) <= 0) {
      return 'Amount must be greater than zero';
    }
    return null;
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String? Function(String?) validator,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdownField<T>({
    required T? value,
    required String hint,
    required List<T> items,
    required void Function(T?)? onChanged,
    required String? Function(T?) validator,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      hint: Text(hint),
      onChanged: onChanged,
      validator: validator,
      items: items.map<DropdownMenuItem<T>>((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()), // Customize this if needed
        );
      }).toList(),
    );
  }


  Widget _buildCheckbox({
    required String title,
    required bool value,
    required void Function(bool?)? onChanged,
  }) {
    return Expanded(
      child: CheckboxListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff330066),
        leading: Icon(Icons.arrow_back,color: Colors.white),
        title: Text('Bank Transfer Form',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionLabel("Select Bank"),
                _buildDropdownField<BanksListModel>(
                  value: selectedBank,
                  hint: 'Select Bank',
                  items: bankslist,
                  onChanged: (value) {
                    setState(() {
                      selectedBank = value!;
                    });
                  },
                  validator: (value) => value == null ? 'Please select a bank' : null,
                ),
                SizedBox(height: 16),
                _buildSectionLabel("Transaction Type"),
                Row(
                  children: [
                    _buildCheckbox(
                      title: 'NEFT',
                      value: isNEFTChecked,
                      onChanged: (value) {
                        setState(() {
                          isNEFTChecked = value ?? false;
                        });
                      },
                    ),
                    _buildCheckbox(
                      title: 'IMPS',
                      value: isIMPSChecked,
                      onChanged: (value) {
                        setState(() {
                          isIMPSChecked = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildSectionLabel("Account Details"),
                _buildTextFormField(
                  controller: accountNumberController,
                  validator: _validateAccountNumber,
                  label: 'Account Number',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: ifscCodeController,
                  validator: _validateIFSCCode,
                  label: 'IFSC Code',
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: accountHolderNameController,
                  validator: _validateNotEmpty,
                  label: 'Account Holder Name',
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: amountController,
                  validator: _validateAmount,
                  label: 'Amount',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: senderNameController,
                  validator: _validateNotEmpty,
                  label: 'Sender Name',
                ),
                SizedBox(height: 16),
                _buildSectionLabel("Beneficiary Type"),
                _buildDropdownField<String>(
                  value: selectedBeneficiaryType,
                  hint: 'Beneficiary Type',
                  items: beneficiaryTypes,
                  onChanged: (value) {
                    setState(() {
                      selectedBeneficiaryType = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select beneficiary type' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Handle form submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}