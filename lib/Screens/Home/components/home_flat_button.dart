import 'package:flutter/material.dart';

class HomePageFlatButton extends StatelessWidget {
  const HomePageFlatButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.image,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final String image;
  final String icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                height: size.height * 0.15,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Image.asset(
                      icon,
                      height: size.height * 0.055,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
