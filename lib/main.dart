import 'package:flutter/material.dart'; // Importa o pacote principal do Flutter para construir a interface do usuário
import 'package:firebase_core/firebase_core.dart'; // Importa o pacote para inicializar o Firebase
import 'login.dart'; // Importa o arquivo 'login.dart' que provavelmente contém a tela de login

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que a ligação dos widgets do Flutter esteja inicializada antes de usar qualquer plugin
  await Firebase.initializeApp(); // Inicializa o Firebase na aplicação
  runApp(const MyApp()); // Executa a aplicação iniciando pela classe MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Construtor da classe MyApp com uma chave opcional

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Define o tema da aplicação como escuro
      home: LoginScreen(), // Define a tela inicial como LoginScreen (definida em 'login.dart')
      debugShowCheckedModeBanner: false, // Remove o banner de "debug" no canto superior direito
    );
  }
}
