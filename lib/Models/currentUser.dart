class CurrentUser {
  static String? userID = "NA";
  static String? userType = "Customer";
  static String? userStatus = "Active";

  static String? get getuserID {
    return userID;
  }

  static set setuserID(String? uID) {
    userID = uID;
  }

  static String? get getuserType {
    return userType;
  }

  static set setuserType(String? uType) {
    userType = uType;
  }

  static String? get getuserStatus {
    return userStatus;
  }

  static set setuserStatus(String? uType) {
    userStatus = uType;
  }
}
