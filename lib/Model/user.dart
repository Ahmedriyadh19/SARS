class User {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? address;
  String? role;
  String? pictureUrl;
  String? phone;
  String? gander;
  String? userName;

  User({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.address,
    this.role,
    this.pictureUrl,
    this.phone,
    this.gander,
    this.userName,
  });

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email, password: $password, address: $address, role: $role, pictureUrl: $pictureUrl, phone: $phone, gander: $gander,  userName: $userName)';
  }
}
