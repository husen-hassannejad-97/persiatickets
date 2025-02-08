import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomValueListenableBuilder<T> extends StatefulWidget {
  const CustomValueListenableBuilder({
    super.key,
    required this.valueListenable,
    required this.listener,
    required this.builder,
    this.child,
  });
  final ValueListenable<T> valueListenable;
  final Function(BuildContext context) listener;
  final ValueWidgetBuilder<T> builder;
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _CustomValueListenableBuilderState<T>();
}

class _CustomValueListenableBuilderState<T> extends State<CustomValueListenableBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(CustomValueListenableBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    widget.listener(context);
    setState(() { value = widget.valueListenable.value; });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
