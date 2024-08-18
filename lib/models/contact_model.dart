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

String jsonString = '''
  {
    "contacts": [
      {
        "id": "1",
        "name": "Alice Johnson",
        "phone": "+1234567890",
        "avatar": "https://picsum.photos/200/300"
      },
      {
        "id": "2",
        "name": "Bob Smith",
        "phone": "+0987654321",
        "avatar": "https://picsum.photos/200/300"
      },
      {
        "id": "3",
        "name": "Charlie Brown",
        "phone": "+1122334455",
        "avatar": "https://picsum.photos/200/300"
      },
      {
        "id": "4",
        "name": "David Williams",
        "phone": "+5566778899",
        "avatar": "https://picsum.photos/200/300"
      },
      {
        "id": "5",
        "name": "Eva Green",
        "phone": "+2244668800",
        "avatar": "https://picsum.photos/200/300"
      }
    ]
  }
  ''';

class ContactsList {
  final List<Contact> contacts;

  ContactsList({required this.contacts});

  // Factory constructor to create a ContactsList from JSON
  factory ContactsList.fromJson(Map<String, dynamic> json) {
    var list = json['contacts'] as List;
    List<Contact> contactsList = list.map((i) => Contact.fromJson(i)).toList();

    return ContactsList(contacts: contactsList);
  }

  // Method to convert a ContactsList to JSON
  Map<String, dynamic> toJson() {
    return {
      'contacts': contacts.map((contact) => contact.toJson()).toList(),
    };
  }
}
