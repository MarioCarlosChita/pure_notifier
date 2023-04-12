import 'package:flutter/widgets.dart';

import 'pure_notifier.dart';

class PureBuilder extends StatefulWidget {
  const PureBuilder({
    super.key,
    required this.notifier,
    required this.initialBuilder,
    this.loadingBuilder,
    this.failureBuilder,
    this.successBuilder,
    this.loadingListener,
    this.failureListener,
    this.successListener,
    this.showDebugMessage = false,
  });

  final PureNotifier notifier;
  final Widget Function(
    BuildContext context,
  ) initialBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context)? failureBuilder;
  final Widget Function(BuildContext context)? successBuilder;
  final void Function()? loadingListener;
  final void Function()? failureListener;
  final void Function()? successListener;
  final bool showDebugMessage;

  @override
  State<PureBuilder> createState() => _PureBuilderState();
}

class _PureBuilderState extends State<PureBuilder> {
  void _showDebugMessage(String message) {
    if (widget.showDebugMessage) {
      debugPrint('${widget.notifier.runtimeType}: $message');
    }
  }

  @override
  void initState() {
    widget.notifier.addListener(() {
      final status = widget.notifier.state.status;
      if (status.isLoading && widget.loadingListener != null) {
        widget.loadingListener!();
        _showDebugMessage('LOADING!');
      }
      if (status.isFailure && widget.failureListener != null) {
        widget.failureListener!();
        _showDebugMessage('FAILURE!');
      }
      if (status.isSuccess && widget.successListener != null) {
        widget.successListener!();
        _showDebugMessage('SUCCESS!');
      }
    });
    super.initState();
    _showDebugMessage('STARTED!');
  }

  @override
  void dispose() {
    widget.notifier.dispose();
    super.dispose();
    _showDebugMessage('DISPOSED!');
  }

  @override
  Widget build(BuildContext context) {
    _showDebugMessage('BUILDED!');
    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        Widget child = widget.initialBuilder(context);
        final status = widget.notifier.state.status;
        if (status.isLoading && widget.loadingBuilder != null) child = widget.loadingBuilder!(context);
        if (status.isFailure && widget.failureBuilder != null) child = widget.failureBuilder!(context);
        if (status.isSuccess && widget.successBuilder != null) child = widget.successBuilder!(context);
        return child;
      },
    );
  }
}
