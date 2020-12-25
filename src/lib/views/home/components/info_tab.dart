import 'package:flutter/material.dart';
import 'package:src/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedPainter()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                "Profile",
                style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Avatar(photo: user.avatar),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textField(icon: Icons.person, data: user.name ?? ''),
                  textField(icon: Icons.email, data: user.email ?? ''),
                  textField(icon: Icons.phone, data: ''),
                  FlatButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(AuthenticationLogoutRequested());
                    },
                    child: Center(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 25,
                            color: Colors.red,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 25, color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget textField({IconData icon, String data}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.orange[900],
              size: 40,
            ),
            Text(
              data,
              style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

const _avatarSize = 80.0;

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

class HeaderCurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.orange[900];
    Path path = Path()
      ..relativeLineTo(0, 350)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 250)
      ..relativeLineTo(0, -250)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HeaderCurvedPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(HeaderCurvedPainter oldDelegate) => false;
}
