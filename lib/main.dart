import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lilac_interview_task/controller/bottomnav_controller.dart';
import 'package:lilac_interview_task/controller/expense_provider.dart';
import 'package:lilac_interview_task/view/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => BottomnavController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expenzia',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: const Color(0xFF2F7E79),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2F7E79),
            primary: const Color(0xFF2F7E79),
            secondary: const Color(0xFF42887D),
            surface: Colors.white,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFF2F7E79),
            selectionColor: Color(0xFFD4E7E3),
            selectionHandleColor: Color(0xFF2F7E79),
          ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: Colors.white,
            headerBackgroundColor: const Color(0xFF2F7E79),
            headerForegroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFF2F7E79);
              }
              return null;
            }),
            dayForegroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return const Color(0xFF1E1E1E);
            }),
            todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFF2F7E79);
              }
              return Colors.transparent;
            }),
            todayForegroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return const Color(0xFF2F7E79);
            }),
            todayBorder: const BorderSide(
              color: Color(0xFF2F7E79),
              width: 1.5,
            ),
            confirmButtonStyle: ButtonStyle(
              foregroundColor:
                  WidgetStateProperty.all(const Color(0xFF2F7E79)),
              textStyle: WidgetStateProperty.all(
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            cancelButtonStyle: ButtonStyle(
              foregroundColor:
                  WidgetStateProperty.all(const Color(0xFF6B7280)),
            ),
          ),
        ),
        builder: (context, child) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: child,
          );
        },
        home: const SplashScreen(),
      ),
    );
  }
}

