import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoundButton extends StatelessWidget {
  bool loading = false;
  String name;
  VoidCallback onTab;
  RoundButton(
      {super.key,
      required this.name,
      required this.onTab,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: 50,
        width: 90,
        child: loading
            ? CircularProgressIndicator(
                color: Colors.black,
              )
            : Text(name),
        alignment: Alignment.center,
        //     color: Colors.blue,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(20)
            //   color: Colors.blue,
            ),
      ),
    );
  }
}
