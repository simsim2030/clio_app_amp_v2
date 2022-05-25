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
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.24,
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  image,
                  width: size.width * 0.4,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Icon(
                        icon,
                        size: 36,
                        color: Colors.white70,
                      ),
                      // height: size.height * 0.055,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
