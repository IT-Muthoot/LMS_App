class LeadDataModel {
  int? id;
  String? additionalPhoneNumber;
  String? email;
  String? dateOfBirth;
  String? nationality;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? landMark;
  String? leadAmount;
  String? monthlyIncomeOfApplicant;
  String? aadharCardNumber;
  String? panCardNumber;
  String? visitId;
  String? gender;
  String? pincode;
  String? district;
  String? state;
  String? postOffice;
  String? residentialType;
  String? residentialStatus;
  String? productCategory;
  String? product;
  String? customerProfile;
  String? employeeCategory;
  String? monthlyIncome;
  bool? isKYCChecked;
  bool? isCrifChecked;



  LeadDataModel({
    this.id,
    required this.additionalPhoneNumber,
    required this.email,
    required this.dateOfBirth,
    required this.nationality,
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.city,
    required this.landMark,
    required this.leadAmount,
    required this.monthlyIncomeOfApplicant,
    required this.aadharCardNumber,
    required this.panCardNumber,
    required this.visitId,
    required this.gender,
    required this.pincode,
    required this.district,
    required this.state,
    required this.postOffice,
    required this.residentialType,
    required this.residentialStatus,
    required this.productCategory,
    required this.product,
    required this.customerProfile,
    required this.employeeCategory,
    required this.monthlyIncome,
    required this.isKYCChecked,
    required this.isCrifChecked,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'additional_phone_number': additionalPhoneNumber,
      'email': email,
      'date_of_birth': dateOfBirth,
      'nationality': nationality,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'address_line_3': addressLine3,
      'city': city,
      'land_mark': landMark,
      'lead_amount': leadAmount,
      'monthly_income': monthlyIncomeOfApplicant,
      'aadhar_number': aadharCardNumber,
      'pan_number': panCardNumber,
      'gender': gender,
      'pincode': pincode,
      'visit_Id': visitId,
      'district': district,
      'state': state,
      'post_office': postOffice,
      'residential_type': residentialType,
      'residential_status': residentialStatus,
      'product_category': productCategory,
      'product': product,
      'customer_profile': customerProfile,
      'employee_category': employeeCategory,
      'is_kycchecked': isKYCChecked == true ? 1 : 0,
      'is_crifchecked': isCrifChecked == true ? 1 : 0,
    };
  }

  factory LeadDataModel.fromMap(Map<String, dynamic> map) {
    return LeadDataModel(
      id: map['id'],
      additionalPhoneNumber: map['additional_phone_number'],
      email: map['email'],
      dateOfBirth: map['date_of_birth'],
      nationality: map['nationality'],
      addressLine1: map['address_line_1'],
      addressLine2: map['address_line_2'],
      addressLine3: map['address_line_3'],
      city: map['city'],
      landMark: map['land_mark'],
      leadAmount: map['lead_amount'],
      monthlyIncomeOfApplicant: map['monthly_income'],
      aadharCardNumber: map['aadhar_number'],
      panCardNumber: map['pan_number'],
      pincode: map['pincode'],
      district: map['district'],
      state: map['state'],
      postOffice: map['post_office'],
      residentialType: map['residential_type'],
      residentialStatus: map['residential_status'],
      productCategory: map['product_category'],
      product: map['product'],
      customerProfile: map['customer_profile'],
      employeeCategory: map['employee_category'],
      monthlyIncome: map['monthly_income'], visitId: map['visit_Id'], gender:map['gender'],
      isKYCChecked: map['is_kycchecked'] == 1 ? true : false, // Convert integer to boolean
      isCrifChecked: map['is_crifchecked'] == 1 ? true : false,
    );
  }
}
