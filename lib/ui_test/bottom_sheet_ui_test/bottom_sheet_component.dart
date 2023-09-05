import 'package:flutter/material.dart';

class BottomSheetComponent extends StatefulWidget {
  const BottomSheetComponent({
    super.key,
    // required this.onValueSelected,
  });


  static Future<BottomSheetComponentModel?> show(BuildContext context,/* ValueChanged<String> onValueSelected*/) {
    return showModalBottomSheet<BottomSheetComponentModel>(
      context: context,
      isDismissible: true,
      builder: (context) {
        return const BottomSheetComponent();
      },
    );
  }

  @override
  State<BottomSheetComponent> createState() => _BottomSheetComponentState();
}

class _BottomSheetComponentState extends State<BottomSheetComponent> with _ComponentMixin{

  @override
  Widget build(BuildContext context) {
    const String _titleButton = 'Save';
    return Column(
      children: [
        TextField(
          onChanged: _updateTextField,
        ),
        Checkbox(value: _isCheck, onChanged: _updateCheckBox,),
        IgnorePointer(
          ignoring: !_isValid,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _isValid ? 1 : 0.5,
            child: ElevatedButton(
                onPressed: _saveButtonOnPressed,
                child: const Text(_titleButton)),
          ),
        )
      ],
    );
  }


}

mixin _ComponentMixin on State<BottomSheetComponent>{
  bool _isCheck = false;
  String _textValue = "";

  bool get _isValid => _isCheck && _textValue.isNotEmpty;
  void _saveButtonOnPressed(){
    if(!_isValid) return;
    Navigator.of(context).pop(BottomSheetComponentModel(value: _textValue, isCheck: _isCheck));
    /*return !_isValid ? null : () {
      // onValueSelected.call(_controller.text);
      Navigator.of(context).pop(BottomSheetComponentModel(value: _textValue, isCheck: _isCheck));
    };*/
  }

  void _updateCheckBox(bool? value){
    if(value == null) return;
    setState(() {
      _isCheck = value;
    });
  }
  void _updateTextField(String value){
    setState(() {
      _textValue = value;
    });
  }
}

class BottomSheetComponentModel{
  final String value;
  final bool isCheck;

  BottomSheetComponentModel({required this.value, required this.isCheck});
}