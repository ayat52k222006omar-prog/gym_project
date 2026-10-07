import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الصووووووورة اعاااااااااااااا
          Positioned.fill(
            child: Image.network(
              "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/763c22ea-62dd-41e7-a659-f5f099c2fb29/debmy0w-94162595-cbd3-4edd-83ff-4cba189fa133.jpg/v1/fill/w_623,h_1282,q_70,strp/wallpaper_gojo_by_toniozintobr_debmy0w-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTQ4MCIsInBhdGgiOiJcL2ZcLzc2M2MyMmVhLTYyZGQtNDFlNy1hNjU5LWY1ZjA5OWMyZmIyOVwvZGVibXkwdy05NDE2MjU5NS1jYmQzLTRlZGQtODNmZi00Y2JhMTg5ZmExMzMuanBnIiwid2lkdGgiOiI8PTcyMCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.F3vJ0Bj74ZFVf0-Y2HOqD5AGvua02gj0zd0YixON6UQ",
              fit: BoxFit.cover,
            ),
          ),

         
          
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),

                      Spacer(),
                      
                      Card(
                        elevation: 8.0, 
                        color: Colors.white,
                        margin: EdgeInsets.zero, 
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                             bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                
                                TextFormField(
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person_outline, color: Colors.grey),
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),

                               
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.mail_outline, color: Colors.grey),
                                    hintText: "Phone or Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 2),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your email or phone";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),

                               
                                TextFormField(
                                  obscureText: _obscurePassword,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.lock_outline, color: Colors.grey),
                                    hintText: "Password",
                                    hintStyle: const TextStyle(color: Colors.grey),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 2),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.length < 6) {
                                      return "Password should be more than 6 letters";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),

                               
                                TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.lock_outline, color: Colors.grey),
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    suffixIcon: Icon(Icons.visibility_off, color: Colors.grey, size: 20),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // زرار Sign up 
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: MaterialButton(
                                    color: const Color(0xFF1548D1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    onPressed: () {
                                      _formKey.currentState!.validate();
                                    },
                                    child: const Text(
                                      "Sign up",
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // لو عنده اكونت 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account? ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        
                                      },
                                      child: const Text(
                                        "Sign in",
                                        style: TextStyle(
                                          color: Color(0xFF1548D1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}