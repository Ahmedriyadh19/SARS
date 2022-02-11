import 'dart:convert';

class User {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? address;
  String? role;
  String? pictureUrl;
  String? phone;

  User({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.address,
    this.role,
    this.pictureUrl,
    this.phone,
  });

  User copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    String? address,
    String? role,
    String? pictureUrl,
    String? phone,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      role: role ?? this.role,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'role': role,
      'pictureUrl': pictureUrl,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      address: map['address'],
      role: map['role'],
      pictureUrl: map['pictureUrl'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email, password: $password, address: $address, role: $role, pictureUrl: $pictureUrl, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.address == address &&
        other.role == role &&
        other.pictureUrl == pictureUrl &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        address.hashCode ^
        role.hashCode ^
        pictureUrl.hashCode ^
        phone.hashCode;
  }
}
