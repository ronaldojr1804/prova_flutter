import 'package:flutter/material.dart';

class InputAddUserCard extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onSave;
  final void Function(String)? onChanged;
  final bool showIcon;
  const InputAddUserCard({
    super.key,
    required this.controller,
    this.onSave,
    this.onChanged,
    this.focusNode,
    this.showIcon = true,
  });

  @override
  State<InputAddUserCard> createState() => _InputAddUserCardState();
}

class _InputAddUserCardState extends State<InputAddUserCard> {
  String baseText = '';
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Digite seu texto',
        fillColor: Colors.white,
        filled: true,
        counterText: '',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: (widget.showIcon)
            ? IconButton(
                onPressed: () {
                  if (widget.onSave != null) {
                    widget.onSave!(baseText);
                  }
                },
                icon: const Icon(Icons.save_rounded),
                splashRadius: 20,
              )
            : null,
      ),
      onChanged: (value) {
        baseText = value;
        if (widget.onChanged != null) {
          widget.onChanged!(baseText);
        }
      },
      onFieldSubmitted: (value) {
        if (widget.onSave != null) {
          widget.onSave!(baseText);
        }
      },
    );
  }
}
