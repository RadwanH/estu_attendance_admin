import '../entities/entities.dart';

class MyUser {
  String userId;
  int tcId;
  String email;
  String name;
  String lastname;
  String? photoUrl;
  String type;
  // final Course[] courses;

  MyUser({
    required this.userId,
    required this.tcId,
    required this.email,
    required this.name,
    required this.lastname,
    this.photoUrl,
    required this.type,
    // this.courses,
  });

  static final empty = MyUser(
    userId: '',
    tcId: 0,
    email: '',
    name: '',
    lastname: '',
    type: '',
    // courses = [''],
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      tcId: tcId,
      email: email,
      name: name,
      lastname: lastname,
      photoUrl: photoUrl,
      type: type,
      // courses: courses,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      tcId: entity.tcId,
      email: entity.email,
      name: entity.name,
      lastname: entity.lastname,
      photoUrl: entity.photoUrl,
      type: entity.type,
      // courses: entity.courses,
    );
  }

  @override
  String toString() {
    return '''MyUser { userId: $userId, tcId: $tcId, email: $email, name: $name, lastname: $lastname, photoUrl: $photoUrl, type: $type }''';
  }
}
