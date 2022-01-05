class Borrowed {
  int? id;
  String? firstName;
  String? lastName;
  int? phoneNumber;
  int? quantite;
  int? idMaterial;
  String? state;
  DateTime? dateReturn;
  Borrowed(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.idMaterial,
      required this.quantite,
      required this.state,
      required this.dateReturn});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'quantite': quantite,
      'idMaterial': idMaterial,
      'state': state,
      'dateReturn':
          dateReturn != null ? dateReturn!.microsecondsSinceEpoch : null
    };
  }

  static Borrowed fromMap(Map<String, dynamic> json) {
    return Borrowed(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      quantite: json['quantite'],
      idMaterial: json['idMaterial'],
      state: json['state'],
      dateReturn: json['dateReturn'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(json['dateReturn'])
          : null,
    );
  }
}
