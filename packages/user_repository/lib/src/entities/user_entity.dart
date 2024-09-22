class MyUserEntity {
  final String userId;
  final int tcId;
  final String email;
  final String name;
  final String lastname;
  final String? photoUrl;
  final String type;

  MyUserEntity({
    required this.userId,
    required this.tcId,
    required this.email,
    required this.name,
    required this.lastname,
    this.photoUrl,
    required this.type,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'tcId': tcId,
      'email': email,
      'name': name,
      'lastname': lastname,
      'photoUrl': photoUrl,
      'type': type,
    };
  }

  static MyUserEntity fromDocument(Map<String, Object?> doc) {
    return MyUserEntity(
      userId: doc['userId'] as String,
      tcId: doc['tcId'] as int,
      email: doc['email'] as String,
      name: doc['name'] as String,
      lastname: doc['lastname'] as String,
      photoUrl: doc['photoUrl'] as String?,
      type: doc['type'] as String,
    );
  }
}
