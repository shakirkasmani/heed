import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:heed/application/auth/auth_bloc.dart';
import 'package:heed/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:heed/presentation/routes/router.gr.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              FlushbarHelper.createError(
                message: failure.map(
                  cancelledByUser: (_) => 'Cancelled',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUse: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid email and password combination',
                ),
              ).show(context);
            },
            (_) {
              ExtendedNavigator.of(context).replace(Routes.notesOverviewPage);
              context
                  .bloc<AuthBloc>()
                  .add(const AuthEvent.authCheckRequested());
            },
          ),
        );
      },
      builder: (context, state) {
        final height = MediaQuery.of(context).size.height;
        return SafeArea(
          child: Stack(
            children: [
              Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Container(
                    height: height * 0.92,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.sticky_note_2_rounded,
                              size: height / 4,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Container(
                              width: height / 4,
                              child: const AutoSizeText(
                                'HEED',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 92, fontWeight: FontWeight.w900),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  // prefixIcon: Icon(Icons.email),
                                  labelText: 'Email',
                                  contentPadding: EdgeInsets.all(20),
                                ),
                                autocorrect: false,
                                onChanged: (value) => context
                                    .bloc<SignInFormBloc>()
                                    .add(SignInFormEvent.emailChanged(value)),
                                validator: (_) => context
                                    .bloc<SignInFormBloc>()
                                    .state
                                    .emailAddress
                                    .value
                                    .fold(
                                      (f) => f.maybeMap(
                                        invalidEmail: (_) => 'Invalid Email',
                                        orElse: () => null,
                                      ),
                                      (_) => null,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                decoration: const InputDecoration(
                                  // prefixIcon: Icon(Icons.lock),
                                  labelText: 'Password',
                                  contentPadding: EdgeInsets.all(20),
                                ),
                                autocorrect: false,
                                obscureText: true,
                                onChanged: (value) => context
                                    .bloc<SignInFormBloc>()
                                    .add(
                                        SignInFormEvent.passwordChanged(value)),
                                validator: (_) => context
                                    .bloc<SignInFormBloc>()
                                    .state
                                    .password
                                    .value
                                    .fold(
                                      (f) => f.maybeMap(
                                        shortPassword: (_) => 'Short Password',
                                        orElse: () => null,
                                      ),
                                      (_) => null,
                                    ),
                              ),
                              // const SizedBox(height: 8),
                              // Text('Forgot password?')
                            ]),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  context.bloc<SignInFormBloc>().add(
                                        const SignInFormEvent
                                            .signInWithEmailAndPasswordPressed(),
                                      );
                                },
                                child: const Text('SIGN IN'),
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  context.bloc<SignInFormBloc>().add(
                                        const SignInFormEvent
                                            .registerWithEmailAndPasswordPressed(),
                                      );
                                },
                                child: const Text('REGISTER'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Center(child: Text('OR')),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.bloc<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .signInWithGooglePressed());
                          },
                          // color: Colors.lightBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: const Text(
                              'SIGN IN WITH GOOGLE',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              state.isSubmitting ? LinearProgressIndicator() : Container(),
            ],
          ),
        );
      },
    );
  }
}
