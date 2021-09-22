import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:heed/application/auth/auth_bloc.dart';
import 'package:heed/presentation/notes/note_search/note_search.dart';
import 'package:heed/presentation/notes/notes_overview/widgets/title_animation_widget.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => showSearch(
        context: context,
        delegate: NoteSearch(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          color: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 48,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color:
                          Theme.of(context).iconTheme.color.withOpacity(0.72),
                    ),
                    onPressed: () => null,
                  ),
                  const TitleAnimationWidget(),
                  IconButton(
                    icon: Icon(
                      Icons.account_circle_rounded,
                      color:
                          Theme.of(context).iconTheme.color.withOpacity(0.72),
                    ),
                    onPressed: () => context
                        .bloc<AuthBloc>()
                        .add(const AuthEvent.signedOut()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
