import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserModel extends Equatable {
  final String email;
  final String id;
  final String name;
  final String role;
  final String photo;

  const UserModel(
      {@required this.email,
      @required this.id,
      @required this.name,
      @required this.role,
      @required this.photo})
      : assert(email != null),
        assert(id != null);

  static const empty = UserModel(email: '', id: '', name: null, role: null, photo: null);
  
  @override
  List<Object> get props => [email, id, name, role, photo];
}
