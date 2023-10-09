class UserDetailsResponse {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? roleCode;
  int? employerId;
  int? employeeId;
  String? employeeType;
  String? token;
  String? tokenExpiry;
  bool? isSelfManaged;
  bool? ddlSwitch;
  String? iRDNumber;
  String? profilePicture;

  UserDetailsResponse(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.roleCode,
      this.employerId,
      this.employeeId,
      this.employeeType,
      this.token,
      this.tokenExpiry,
      this.isSelfManaged,
      this.ddlSwitch,
      this.iRDNumber,
      this.profilePicture});

  UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    roleCode = json['RoleCode'];
    employerId = json['EmployerId'];
    employeeId = json['EmployeeId'];
    employeeType = json['EmployeeType'];
    token = json['Token'];
    tokenExpiry = json['TokenExpiry'];
    isSelfManaged = json['IsSelfManaged'];
    ddlSwitch = json['ddlSwitch'];
    iRDNumber = json['IRDNumber'];
    profilePicture = json['ProfilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['RoleCode'] = roleCode;
    data['EmployerId'] = employerId;
    data['EmployeeId'] = employeeId;
    data['EmployeeType'] = employeeType;
    data['Token'] = token;
    data['TokenExpiry'] = tokenExpiry;
    data['IsSelfManaged'] = isSelfManaged;
    data['ddlSwitch'] = ddlSwitch;
    data['IRDNumber'] = iRDNumber;
    data['ProfilePicture'] = profilePicture;
    return data;
  }
}
