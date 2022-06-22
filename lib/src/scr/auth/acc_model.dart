class Account {
  late String user;
  late String passKey;

  Account({required this.user, required this.passKey});

  Account.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    passKey = json['passKey'];
  }

  bool userExists(String _query) {
    return user == _query;
  }

  bool auth(String _usr, String _pwd) {
    if (user == _usr && passKey == _pwd) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'passKey': passKey,
    };
  }
}
