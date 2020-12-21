import 'package:flutter/material.dart';
import 'package:src/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Container(
      child: Align(alignment: const Alignment(0, -1/3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Avatar(photo: user.avatar),
            const SizedBox(height: 4.0),
            Text(user.email, style: textTheme.headline6),
            const SizedBox(height: 4.0),
            Text(user.name ?? '', style: textTheme.headline5),
        ],
      ),),
    );
  }
}

const _avatarSize = 48.0;
class Avatar extends StatelessWidget {
  const Avatar({Key key, this.photo}) : super(key: key);
  
  final String photo;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: _avatarSize,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child: photo == null
          ? const Icon(Icons.person_outline, size: _avatarSize)
          : null,
    );
  }
}