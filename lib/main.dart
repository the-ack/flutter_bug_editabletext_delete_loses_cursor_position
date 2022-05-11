import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KeyboardDemo(),
    );
  }
}

class KeyboardDemo extends StatefulWidget {
  @override
  _KeyboardDemoState createState() => _KeyboardDemoState();
}

class _KeyboardDemoState extends State<KeyboardDemo> {
  TextEditingController _controller = TextEditingController();
  late FocusNode _focusNode;

  bool _readOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: EditableText(
                controller: _controller,
                focusNode: _focusNode,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
                backgroundCursorColor: Colors.grey,
                autocorrect: false,
                autofocus: true,
                showCursor: true,
                readOnly: _readOnly,
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                  cut: false,
                  paste: false,
                  selectAll: false,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('EditableText readOnly state: '),
                Switch(
                  value: _readOnly,
                  onChanged: (value) {
                    setState(() {
                      _readOnly = value;
                    });
                  },
                ),
              ],
            ),
            CustomKeyboard(
              onTextInput: (myText) {
                _insertText(myText);
              },
              onBackspace: () {
                _backspace();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class CustomKeyboard extends StatelessWidget {
  CustomKeyboard({
    Key? key,
    this.onTextInput,
    this.onBackspace,
  }) : super(key: key);

  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;

  void _textInputHandler(String text) => onTextInput!.call(text);
  void _backspaceHandler() => onBackspace?.call();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                TextKey(
                  text: 'A',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: 'B',
                  onTextInput: _textInputHandler,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                TextKey(
                  text: ' ',
                  flex: 3,
                  onTextInput: _textInputHandler,
                ),
                BackspaceKey(
                  onBackspace: _backspaceHandler,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    this.text,
    this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String? text;
  final ValueSetter<String>? onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.blue.shade100,
          child: InkWell(
            onTap: () {
              onTextInput?.call(text!);
            },
            child: Container(
              child: Center(child: Text(text!)),
            ),
          ),
        ),
      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback? onBackspace;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.blue.shade100,
          child: InkWell(
            onTap: () {
              onBackspace?.call();
            },
            child: Container(
              child: Center(
                child: Icon(Icons.backspace),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
