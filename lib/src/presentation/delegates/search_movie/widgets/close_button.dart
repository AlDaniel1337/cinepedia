import 'package:flutter/material.dart';

class CloseBtn extends StatelessWidget {

  final void Function()? onPressed;
   
  const CloseBtn({
    super.key,
    this.onPressed
  });
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: const Icon( Icons.arrow_back_ios_new_rounded )
    );
  }
}