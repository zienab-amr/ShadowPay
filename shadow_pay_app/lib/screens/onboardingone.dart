import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF6366F1);
  static const Color secondaryPurple = Color(0xFF8B5CF6);
  static const Color verifiedGreen = Colors.green;
  static const Color riskOrange = Colors.orange;
}

// ShieldPainter هنا
class ShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = AppTheme.primaryPurple;

    final path = Path();
    final centerX = size.width / 2;
    
    path.moveTo(centerX, size.height * 0.2);
    path.lineTo(size.width * 0.7, size.height * 0.3);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.lineTo(centerX, size.height * 0.8);
    path.lineTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.3);
    path.close();

    canvas.drawPath(path, paint);

    final lockPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, size.height * 0.45),
          width: 30,
          height: 25,
        ),
        const Radius.circular(5),
      ),
      lockPaint,
    );
    
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, size.height * 0.35),
        width: 20,
        height: 20,
      ),
      3.14,
      3.14,
      false,
      lockPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class Onboardingone extends StatelessWidget {
  const Onboardingone({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          
          // Status Badges
          Row(
            children: [
              _buildBadge(
                label: 'VERIFIED',
                color: AppTheme.verifiedGreen,
              ),
              const SizedBox(width: 12),
              _buildBadge(
                label: 'ANALYSIS RISK',
                color: AppTheme.riskOrange,
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // Shield Icon
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppTheme.secondaryPurple.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
              child: CustomPaint(
                painter: ShieldPainter(),
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Title
          const Text(
            'Secure Your\nTransactions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
              height: 1.1,
              letterSpacing: -1,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            'Our advanced AI analyzes every transaction in real-time to protect your funds from fraud and unauthorized access.',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}