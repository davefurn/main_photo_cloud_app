import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_photo_cloud_app/lib/bloc/app_bloc.dart';
import 'package:main_photo_cloud_app/lib/bloc/app_event.dart';
import 'package:main_photo_cloud_app/lib/bloc/app_state.dart';
import 'package:main_photo_cloud_app/lib/dialogs/show_auth_error.dart';
import 'package:main_photo_cloud_app/lib/lib/loading/loading_screen.dart';
import 'package:main_photo_cloud_app/lib/lib/views/login_view.dart';
import 'package:main_photo_cloud_app/lib/lib/views/photo_gallery_view.dart';
import 'package:main_photo_cloud_app/lib/lib/views/register_view.dart';


class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Appbloc>(
      create: (_) => Appbloc()
        ..add(
          const AppEventInitialize(),
        ),
      child: MaterialApp(
        title: 'Photo Library',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<Appbloc, AppState>(
          listener: (context, appState) {
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading.....',
              );
            } else {
              LoadingScreen.instance().hide();
            }

            final authError = appState.authError;
            if (authError != null) {
              showAuthError(
                authError: authError,
                context: context,
              );
            }
          },
          builder: (context, appState) {
            if (appState is AppStateLoggedOut) {
              return const LoginView();
            } else if (appState is AppStateLoggedIn) {
              return const PhotoGalleryView();
            } else if (appState is AppStateIsInRegistrationView) {
              return const RegisterView();
            } else {
              //this should never happen
              return Container();
            }
          },
        ),
      ),
    );
  }
}
