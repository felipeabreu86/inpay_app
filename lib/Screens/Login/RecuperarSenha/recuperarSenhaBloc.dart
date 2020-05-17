import 'dart:async';

class RecuperarSenhaBloc {
  /// Variável inteira e seu get
  int _index = 0;
  int get index => _index;

  /// Variável final que inicializa o StreamController
  final _blocController = StreamController<int>();

  /// Stream para observar os eventos desta Bloc
  Stream<int> get stream => _blocController.stream;

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

  /// Fecha a Stream
  fecharStream() {
    _blocController.close();
  }
}
