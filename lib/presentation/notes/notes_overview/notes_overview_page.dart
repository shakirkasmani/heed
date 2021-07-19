import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:heed/application/auth/auth_bloc.dart';
import 'package:heed/application/notes/note_actor/note_actor_bloc.dart';
import 'package:heed/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:heed/injection.dart';
import 'package:heed/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:heed/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:heed/presentation/routes/router.gr.dart';

class NotesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                unauthenticated: (_) =>
                    ExtendedNavigator.of(context).replace(Routes.signInPage),
                orElse: () {},
              );
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                deleteFailure: (state) {
                  FlushbarHelper.createError(
                    duration: const Duration(seconds: 5),
                    message: state.noteFailure.map(
                      unexpected: (_) =>
                          'Unexpected error occured while deleting, please contact support.',
                      insufficientPermission: (_) =>
                          'Insufficient permissions ❌',
                      unableToUpdate: (_) => 'Impossible error',
                    ),
                  ).show(context);
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: Scaffold(
          extendBody: true,
          body: NotesOverviewBody(),
          bottomNavigationBar: _buildBottomAppBar(context),
          floatingActionButton: _buildFAB(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        ExtendedNavigator.of(context).pushNoteFormPage(editedNote: null);
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.92),
      elevation: 10,
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              UncompletedSwitch(),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded),
                onPressed: () => {
                  //TODO menu items 'Filter', 'About', etc.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
