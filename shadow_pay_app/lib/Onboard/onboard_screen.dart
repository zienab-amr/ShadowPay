import 'package:flutter/material.dart';
import 'third_screen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  PageController _controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101622),
     body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              children: const [
                ThirdScreen(),
              ],
            ),
          ),
                      /// indicator
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIndicator(active: index == 0),
              ],
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}


class CustomIndicator extends StatelessWidget {
  final bool active;
  const CustomIndicator({super.key , required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active?Colors.green:Colors.grey,
      ),
      width:active?30:10,
      height: 10,


    );
  }
}
