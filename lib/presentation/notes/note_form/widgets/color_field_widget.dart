import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heed/application/notes/note_form/note_form_bloc.dart';
import 'package:heed/domain/notes/value_objects.dart';

class ColorField extends StatelessWidget {
  const ColorField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFormBloc, NoteFormState>(
      buildWhen: (p, c) => p.note.color != c.note.color,
      builder: (context, state) {
        return Container(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: NoteColor.predefinedColors.length,
            itemBuilder: (context, index) {
              final itemColor = NoteColor.predefinedColors[index];
              return GestureDetector(
                onTap: () {
                  context
                      .bloc<NoteFormBloc>()
                      .add(NoteFormEvent.colorChanged(itemColor));
                },
                child: Material(
                  color: itemColor,
                  elevation: 4,
                  shape: CircleBorder(
                    side: state.note.color != null
                        ? state.note.color.value.fold(
                            (_) => BorderSide.none,
                            (color) {
                              return color == itemColor.withOpacity(0.50)
                                  ? BorderSide(
                                      width: 2.5,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant
                                          .withOpacity(0.50))
                                  : BorderSide.none;
                            },
                          )
                        : BorderSide.none,
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
          ),
        );
      },
    );
  }
}
