import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }
  runApp(const SanadApp());
}

class SanadApp extends StatelessWidget {
  const SanadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق سند',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.light,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// 1. شاشة تسجيل الدخول الأنيقة
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ReportScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال البريد الإلكتروني وكلمة المرور')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shield_rounded, size: 70, color: Color(0xFF3B82F6)),
                const SizedBox(height: 16),
                const Text(
                  'أهلاً بك في تطبيق سند',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'سجل دخولك للمتابعة وإدارة البلاغات',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.email, color: Color(0xFF3B82F6)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF3B82F6)),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 2. شاشة رفع البلاغات
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _fileName;
  final _reportController = TextEditingController();

  void _simulateAttachFile() {
    setState(() {
      _fileName = 'document_report_2026.pdf';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرفاق المستند بنجاح')),
    );
  }

  void _submitReport() {
    if (_reportController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال البلاغ بنجاح وحفظه في قاعدة البيانات!')),
      );
      _reportController.clear();
      setState(() {
        _fileName = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء كتابة تفاصيل البلاغ أولاً')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إرسال بلاغ جديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF0F172A),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'تفاصيل البلاغ أو المشكلة:',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reportController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'اكتب تفاصيل البلاغ هنا بوضوح...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _simulateAttachFile,
              icon: const Icon(Icons.attach_file),
              label: Text(_fileName == null ? 'إرفاق ملف أو مستند' : 'تم اختيار: $_fileName'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('إرسال البلاغ الآن', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
