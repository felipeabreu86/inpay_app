import 'dart:async';

class CadastroBloc {
  /// Variável inteira e seu get
  int _index = 0;
  int get index => _index;

  /// Armazena se o campo senha deve ser visível ou não
  var _passwordVisible = false;

  /// Variável final que inicializa o StreamController
  final _blocController = StreamController<int>();
  final _senhaController = StreamController<bool>();

  /// Stream para observar os eventos desta Bloc
  Stream<int> get stream => _blocController.stream;
  Stream<bool> get streamSenha => _senhaController.stream;

  /// Incremente a variável total e adiciona à Stream
  void atualizar() {
    _index++;
    _blocController.sink.add(index);
  }

  /// Reinicia o contador
  void reiniciar() {
    _index = 0;
    _blocController.sink.add(index);
  }

  // Exibe ou esconde o conteúdo do campo Senha
  void atualizarObscureText() {
    _passwordVisible = !_passwordVisible;
    _senhaController.sink.add(_passwordVisible);
  }

  /// Fecha a Stream
  fecharStream() {
    _blocController.close();
    _senhaController.close();
  }
}
