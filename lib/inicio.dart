import 'package:flutter/material.dart'; // Importa os componentes básicos do Flutter para a interface gráfica
import 'package:firebase_auth/firebase_auth.dart'; // Importa o pacote de autenticação do Firebase
import 'package:login_cadastro/login.dart'; // Importa a tela de login

// Define um widget Stateful para a tela inicial após o login
class InicioScreen extends StatefulWidget {
  @override
  _InicioScreenState createState() => _InicioScreenState();
}

// Estado associado ao InicioScreen
class _InicioScreenState extends State<InicioScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instância do FirebaseAuth para autenticação
  User? _user; // Usuário atual (pode ser nulo)

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser; // Obtém o usuário atualmente logado
  }

  // Método assíncrono para realizar o logout
  Future<void> _logout() async {
    await _auth.signOut(); // Desconecta o usuário
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(), // Navega para a tela de login
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Início'), // Título da AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Ícone de logout
            onPressed: _logout, // Chama o método _logout ao ser pressionado
            tooltip: 'Logout', // Texto exibido ao manter pressionado
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinha os widgets ao centro verticalmente
          children: [
            Text(
              'Bem-vindo, ${_user?.displayName ?? 'Usuário'}!', // Exibe o nome do usuário ou 'Usuário' se for nulo
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo do texto
            ),
            SizedBox(height: 20), // Espaçamento vertical
            Text(
              'Você está logado como ${_user?.email ?? 'Email não disponível'}', // Exibe o email do usuário
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _logout, // Chama o método _logout ao ser pressionado
              child: Text('Logout'), // Texto do botão
            ),
          ],
        ),
      ),
    );
  }
}
