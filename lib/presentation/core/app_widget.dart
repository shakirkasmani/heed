import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heed/application/auth/auth_bloc.dart';
import 'package:heed/injection.dart';
import 'package:heed/presentation/routes/router.gr.dart' as auto_route;
import 'package:heed/presentation/themes/theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'Heed',
        debugShowCheckedModeBanner: false,
        builder: ExtendedNavigator(router: auto_route.Router()),
        theme: HeedThemeData.lightThemeData,
        darkTheme: HeedThemeData.darkThemeData,
      ),
    );
  }
}
