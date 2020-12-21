import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserModel extends Equatable {
  final String email;
  final String id;
  final String name;
  final String role;
  final String avatar;
  final List<String> photos;
  const UserModel(
      {@required this.email,
      @required this.id,
      @required this.name,
      @required this.role,
      @required this.avatar,
      this.photos})
      : assert(email != null),
        assert(id != null);
  static const empty = UserModel(email: '', id: '', name: null, role: null, avatar: null);
  
  @override
  List<Object> get props => [email, id, name, role, avatar];

    UserModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['fullName'],
        email = data['email'],
        role = data['userRole'],
        avatar = data['avatar'],
        photos = data['photos'];

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'fullName': name,
        'email': email,
        'photos': photos,
        'role': role
      };
    }
}
