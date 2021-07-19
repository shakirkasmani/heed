import 'package:flutter/material.dart';
import 'package:heed/domain/notes/note.dart';

class NoteSearch extends SearchDelegate<Note> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isEmpty)
        IconButton(
          icon: Icon(
            Icons.mic_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            ///TODO voice search
          },
        )
      else
        IconButton(
          icon: Icon(
            Icons.clear_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ///TODO search
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ///TODO suggestions
    return Container();
  }
}
