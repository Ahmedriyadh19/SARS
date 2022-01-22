import 'dart:convert';

class User {
  String name;
  String email;
  String password;
  String address;
  String role;
  int phone;

  
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.role,
    required this.phone,
  });

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? address,
    String? role,
    int? phone,
  }) 
  
  {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      role: role ?? this.role,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'role': role,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      role: map['role'] ?? '',
      phone: map['phone']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, email: $email, password: $password, address: $address, role: $role, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.address == address &&
      other.role == role &&
      other.phone == phone;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      address.hashCode ^
      role.hashCode ^
      phone.hashCode;
  }
}
