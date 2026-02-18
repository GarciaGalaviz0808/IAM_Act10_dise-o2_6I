import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  bool _isObscured = true;

  // Paleta de colores
  final Color darkBrown = const Color(0xFF3E2723);    // Café muy oscuro (Letras)
  final Color mediumBrown = const Color.fromARGB(255, 78, 44, 31);  // Café intermedio (Botones)
  final Color hoverBrown = const Color.fromARGB(255, 133, 93, 78);   // Café más ligero (Hover)
  final Color lightBrown = const Color(0xFFD7CCC8);   // Café muy claro (Fondo)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrown,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. LOGO GRANDE (Esquina superior izquierda)
            Positioned(
              top: 30,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.palette, size: 60, color: darkBrown), // Icono más grande
                  Text(
                    'ArtStore',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                      fontFamily: 'serif',
                    ),
                  ),
                ],
              ),
            ),

            // 2. CONTENIDO CENTRAL
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),

                    // Pincel al lado de la "I" de Iniciar Sesión
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.brush, size: 35, color: darkBrown),
                        const SizedBox(width: 10),
                        Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 32,
                            color: darkBrown,
                            fontFamily: 'serif',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Campo: Usuario
                    _buildLabel(Icons.person_outline, "Nombre de usuario"),
                    const SizedBox(height: 10),
                    _buildTextField(_userController, false),

                    const SizedBox(height: 25),

                    // Campo: Contraseña
                    _buildLabel(Icons.lock_outline, "Contraseña"),
                    const SizedBox(height: 10),
                    _buildTextField(
                      _passController,
                      _isObscured,
                      isPassword: true,
                      onSuffixTap: () => setState(() => _isObscured = !_isObscured),
                    ),

                    const SizedBox(height: 50),

                    // BOTÓN INICIAR SESIÓN CON SOMBRA Y HOVER
                    _buildAnimatedButton(
                      text: "Iniciar Sesión",
                      onPressed: () {
                        print("Usuario: ${_userController.text}");
                        print("Clave: ${_passController.text}");
                      },
                    ),

                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      child: Text('¿Olvidaste contraseña?',
                          style: TextStyle(color: darkBrown, fontSize: 16)),
                    ),

                    const SizedBox(height: 40),
                    Text('¿No tienes cuenta?',
                        style: TextStyle(color: darkBrown.withOpacity(0.8))),
                    const SizedBox(height: 10),

                    // Botón Regístrate pequeño
                    _buildAnimatedButton(
                      text: "Regístrate",
                      isSmall: true,
                      onPressed: () => print("Ir a registro"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para etiquetas con iconos originales
  Widget _buildLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: darkBrown, size: 22),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: darkBrown, fontSize: 17, fontFamily: 'serif')),
      ],
    );
  }

  // Widget para campos de texto funcionales
  Widget _buildTextField(TextEditingController controller, bool obscure,
      {bool isPassword = false, VoidCallback? onSuffixTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        cursorColor: darkBrown,
        style: TextStyle(color: darkBrown),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: darkBrown, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: darkBrown, width: 2.5),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: darkBrown),
                  onPressed: onSuffixTap,
                )
              : null,
        ),
      ),
    );
  }

  // BOTÓN PERSONALIZADO CON EFECTO HOVER Y SOMBRA
  Widget _buildAnimatedButton({required String text, required VoidCallback onPressed, bool isSmall = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) return hoverBrown;
          return mediumBrown; // Color café relleno
        }),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(8), // Sombreado
        shadowColor: WidgetStateProperty.all(Colors.black54),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: isSmall ? 30 : 0, vertical: 15),
        ),
        minimumSize: WidgetStateProperty.all(Size(isSmall ? 120 : double.infinity, 50)),
        shape: WidgetStateProperty.all(const StadiumBorder()),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'serif'),
      ),
    );
  }
}