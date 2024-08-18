

class Contact {
  final String id;
  final String name;
  final String phone;
  final String avatar;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
  });

  // Factory constructor to create a Contact from JSON
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }

  // Method to convert a Contact to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'avatar': avatar,
    };
  }
}
