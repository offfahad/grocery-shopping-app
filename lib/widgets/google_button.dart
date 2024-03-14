import 'package:flutter/material.dart';
import 'package:grocery_shop_app/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/images/google.png',
                  width: 40.0,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              TextWidget(
                  text: 'Sign In With Google',
                  color: Colors.white,
                  textSize: 18)
            ]),
          ),
        ),
      ),
    );
  }
}
