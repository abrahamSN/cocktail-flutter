import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';
import 'package:video_player/video_player.dart';

import '../../blocs/blocs.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    // _controller = VideoPlayerController.network("https://www.sample-videos.com/video123/mp4/720/video312/mp4/720/big_buck_bunny_720p_1mb.mp4")
    //   ..initialize().then(
    //     (_) {
    //       // Once the video has been loaded we play the video and set looping to true.
    //       _controller.play();
    //       _controller.setLooping(true);
    //       // _controller.setVolume(0.0);
    //       // Ensure the first frame is shown after the video is initialized.
    //       setState(() {});
    //     },
    //   );
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          return Container(
            child: Center(
              child: Text('gagal'),
            ),
          );
        }
        if (state.isSuccess) {
          context.bloc<AuthBloc>().add(LoggedIn());
        }
      },
      child: Scaffold(
        body: _bodyBuilder(context, _loginBloc),
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context, LoginBloc _loginBloc) {
    return Stack(
      children: [
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.fill,
            child: SizedBox(
              width: 0,
              height: 0,
              child:
              // _controller.value.initialized
              //     ? VideoPlayer(_controller)
              //     :
              Container(),
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black54,
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/welcome');
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                          shadows: [
                            Shadow(
                              offset: Offset(0.0, 1.0),
                              blurRadius: 5.0,
                              color: Colors.black87,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FlutterLogo(
                size: 100.0,
              ),
              Spacer(),
              _btnSocial(context, _loginBloc),
              _tos(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _btnSocial(BuildContext context, LoginBloc _loginBloc) {
    return Container(
      width: MediaQuery.of(context).size.width * 70 / 100,
      child: Column(
        children: [
          SignInButton(
            imagePosition: ImagePosition.right,
            buttonType: ButtonType.google,
            onPressed: () {
              context.bloc<LoginBloc>().add(LoginWithGooglePressed());
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 0.0,
            ),
            width: double.infinity,
            child: InkWell(
              onTap: () {},
              child: Text(
                'Trouble signin in?',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tos(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 70 / 100,
      padding: EdgeInsets.only(bottom: 20.0),
      child: Text(
        'By continuing, you agree to our \n'
        ' Terms of Service, Privacy Policy and Community Rules.\n'
        ' (CA residents: CCPA)',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _controller.dispose();
  }
}
