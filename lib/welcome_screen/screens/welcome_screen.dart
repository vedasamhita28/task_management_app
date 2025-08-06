import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_management_app/constants/style.dart';
import 'package:task_management_app/widgets/primary_button.dart';
import 'package:task_management_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _pulseController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Entrance animation
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _entranceController, curve: Curves.easeOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _entranceController, curve: Curves.easeIn));

    // Pulse animation for button
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Repeats the pulse

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),

                // 🔼 Top illustration or logo
                Image.asset(
                  'assets/images/welcome_img.png',
                  height: 160,
                ),

                const SizedBox(height: 20),

                // ✨ Shortened welcome text with better color
                Text(
                  'Welcome to Nulinz',
                  style: Style.headingTextStyle.copyWith(
                    color: Colors.blueGrey[800],
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // 🔤 Shorter, smaller description text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'New here? Tap the button below to sign up, or log in if you’re already a team member.',
                    style: Style.subHeadingStyle.copyWith(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                // 🆕 New User button with pulse
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 270,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: PrimaryButton(
                      width: 250,
                      text: "New User",
                      onPressed: () {
                        _pulseController.stop();
                        context.push('/signup');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom), //using viewPadding to avoid navigation buttons overlapping the Welcome Screen buttons
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PrimaryButton(
              width: 170,
              text: "Employee Log In",
              onPressed: () => context.push('/login'),
            ),
            PrimaryButton(
              width: 170,
              text: "TL Log In",
              onPressed: () => context.push('/tl_login'),
            ),
          ],
        ),
      ),
    );
  }
}
