import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id, name, surname, email, ppUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.ppUrl,
  });

  String fullName() => '$name $surname';

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      name: doc['name'],
      surname: doc['surname'],
      email: doc['email'],
      ppUrl: doc['ppUrl'],
    );
  }
}
