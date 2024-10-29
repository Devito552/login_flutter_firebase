import 'package:flutter/material.dart'; // Importa os componentes básicos de interface do Flutter
import 'package:firebase_auth/firebase_auth.dart'; // Importa o pacote de autenticação do Firebase
import 'package:login_cadastro/cadastro.dart'; // Importa a tela de cadastro (registro)
import 'inicio.dart'; // Importa a tela inicial após o login bem-sucedido

// Define um widget Stateful para a tela de login
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// Estado associado ao LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instância do FirebaseAuth para autenticação
  final TextEditingController _emailController = TextEditingController(); // Controlador para o campo de e-mail
  final TextEditingController _passwordController = TextEditingController(); // Controlador para o campo de senha

  // Método assíncrono para realizar o login
  Future<void> _login() async {
    try {
      // Tenta fazer login com e-mail e senha fornecidos
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Se o login for bem-sucedido, navega para a tela inicial
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => InicioScreen(),
        ),
      );
    } catch (e) {
      // Em caso de erro, exibe uma notificação com a mensagem de erro
      _showSnackBar('Erro no login: $e', Colors.red);
    }
  }

  // Método para exibir uma mensagem na parte inferior da tela (SnackBar)
  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 2), // Duração de exibição do SnackBar
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento em todos os lados
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Alinha os filhos ao centro verticalmente
            children: [
              Text(
                'Bem-vindo ao login com Firebase! ;)', // Texto de boas-vindas
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40), // Espaçamento vertical
              TextField(
                controller: _emailController, // Controlador do campo de e-mail
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email), // Ícone à esquerda do campo
                  border: OutlineInputBorder(), // Borda ao redor do campo
                ),
                keyboardType: TextInputType.emailAddress, // Tipo de teclado adequado para e-mail
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController, // Controlador do campo de senha
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Oculta o texto digitado (para senhas)
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _login, // Chama o método _login ao ser pressionado
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Largura total e altura de 50
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navega para a tela de cadastro ao ser pressionado
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()),
                  );
                },
                child: Text('Não tem uma conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
