import 'dart:async';

class LoginBloc {
  /// Armazena o índice referente ao estado do botão login
  int _index = 0;
  int get index => _index;

  /// Armazena se o campo senha deve ser visível ou não
  var _passwordVisible = false;

  // Inicializa o StreamController
  final _btLoginController = StreamController<int>();
  final _senhaController = StreamController<bool>();

  // Streams para observar os eventos desta Bloc
  Stream<int> get streamBtLogin => _btLoginController.stream;
  Stream<bool> get streamSenha => _senhaController.stream;

  // Incrementa o índice que controla o estado do botão de login
  void atualizar() {
    _index++;
    _btLoginController.sink.add(index);
  }

  // Reinicia o índice que controla o estado do botão de login
  void reiniciar() {
    _index = 0;
    _btLoginController.sink.add(index);
  }

  // Exibe ou esconde o conteúdo do campo Senha
  void atualizarObscureText() {
    _passwordVisible = !_passwordVisible;
    _senhaController.sink.add(_passwordVisible);
  }

  // Fecha a Stream
  fecharStream() {
    _btLoginController.close();
    _senhaController.close();
  }
}
