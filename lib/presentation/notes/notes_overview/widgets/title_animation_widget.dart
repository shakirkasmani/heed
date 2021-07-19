import 'package:flutter/material.dart';

class TitleAnimationWidget extends StatefulWidget {
  const TitleAnimationWidget({Key key}) : super(key: key);

  @override
  _TitleAnimationWidgetState createState() => _TitleAnimationWidgetState();
}

class _TitleAnimationWidgetState extends State<TitleAnimationWidget> {
  bool showSearch = false;

  @override
  void initState() {
    super.initState();
    _switch();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: SizedBox(
        width: 200,
        child: Text(
          'HEED',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      secondChild: SizedBox(
        width: 200,
        child: Text(
          'Search',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.72)),
        ),
      ),
      crossFadeState:
          showSearch ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> _switch() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      showSearch = true;
    });
  }
}
