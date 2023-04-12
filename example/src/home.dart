import 'package:flutter/material.dart';
import 'package:pure_notifier/pure_builder.dart';

import 'counter.dart';

class Home extends StatefulWidget {
  const Home(
    this.counter, {
    super.key,
    required this.title,
  });

  final Counter counter;
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    widget.counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(height: 15),
            PureBuilder(
              notifier: widget.counter,
              initialBuilder: (context) => Text('${widget.counter.state.value}'),
              loadingBuilder: (context) => const SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
              failureListener: () => _showMessage(widget.counter.state.message),
            ),
            const SizedBox(height: 15),
            PureBuilder(
              notifier: widget.counter,
              initialBuilder: (context) => ElevatedButton(
                onPressed: widget.counter.state.status.isLoading ? null : widget.counter.increment,
                child: const Text('Increment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
