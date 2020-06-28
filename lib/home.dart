import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  static const wpm = 15;
  static const dot = 1200 / wpm;

  @override
  Widget build(BuildContext context) {
    final messageState = useState('');
    final lastTapState = useState(DateTime.now());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(messageState.value),
            GestureDetector(
              onTapDown: (details) {
                lastTapState.value = DateTime.now();
              },
              onTapUp: (details) {
                final diff = DateTime.now().difference(lastTapState.value);
                if (diff.inMilliseconds < dot) {
                  messageState.value += '.';
                } else {
                  messageState.value += '-';
                }
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
