import 'package:flutter/material.dart';
import 'package:myfirstapp/old_apps/e_commerce_app/core/widget/primary_btn.dart';
import 'package:myfirstapp/old_apps/e_commerce_app/features/auth/view/widgets/custom_textfield.dart';
import 'sign_up_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * .1, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. لوجو صفحة تسجيل الدخول من النت
              Image.network(
                "https://tse2.mm.bing.net/th/id/OIP.IY5UnLaUA-VkdZei8pQKwgHaHa?r=0&pid=ImgDet&w=474&h=474&rs=1&o=7&rm=3", // رابط مباشر للوجو
                height: 120,
                width: 120,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 80),
              ),
              SizedBox(height: height * .1),
              CustomTextfield(text: "Phone Number"),
              SizedBox(height: height * .03),
              CustomTextfield(text: "Password", isPassword: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text("Forget Password?")],
              ),
              SizedBox(height: height * .03),
              PrimaryBtn.greenBtn("Login"),
              SizedBox(height: height * .03),
              
              // 2. أزرار السوشيال ميديا باستخدام روابط الإنترنت مباشرة
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialBtn(
                    "Google", 
                    Colors.red, 
                    "https://static.vecteezy.com/system/resources/previews/035/746/056/large_2x/google-app-logo-in-big-sur-style-3d-render-icon-design-concept-element-isolated-transparent-background-free-png.png"
                  ),
                  const SizedBox(width: 14),
                  socialBtn(
                    "Apple", 
                    Colors.black, 
                    "https://th.bing.com/th/id/OIP.DKlnFQLFQaVX0ROhSM1wgwHaHa?w=175&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3"
                  ),
                ],
              ),
              SizedBox(height: height * .08),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an Account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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

  // دالة زر السوشيال ميديا المعدلة لتستخدم Image.network بدلاً من Image.asset
  Widget socialBtn(String text, Color color, String imageUrl) {
    return Container(
      height: 56,
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl, 
            height: 30, 
            width: 30,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 24),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}