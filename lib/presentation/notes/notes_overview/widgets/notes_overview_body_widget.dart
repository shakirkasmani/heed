import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:heed/application/auth/auth_bloc.dart';

import 'package:heed/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:heed/presentation/notes/notes_overview/widgets/critical_failure_display_widget.dart';
import 'package:heed/presentation/notes/notes_overview/widgets/note_card_widget.dart';
import 'package:heed/presentation/notes/notes_overview/widgets/search_bar_widget.dart';
import 'package:heed/presentation/routes/router.gr.dart';

class NotesOverviewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          unauthenticated: (_) =>
              ExtendedNavigator.of(context).replace(Routes.signInPage),
          orElse: () {},
        );
      },
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              elevation: 0,
              toolbarHeight: 86,
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
              title: SearchBarWidget(),
            ),
          ];
        },
        body: BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => Container(),
              loadInProgress: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              loadSuccess: (state) {
                final double bottomPadding = Platform.isIOS ? 128.0 : 88.0;
                return StaggeredGridView.countBuilder(
                  padding: EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: bottomPadding),
                  crossAxisCount: 2,
                  itemCount: state.notes.size,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    if (note.failureOption.isSome()) {
                      return const Center(
                        child: Text('Error'),
                      );
                    } else {
                      return NoteCard(note: note);
                    }
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                );
              },
              loadFailure: (state) {
                return CriticalFailureDisplay(
                  failure: state.noteFailure,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
