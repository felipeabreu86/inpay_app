import 'package:inpay_app/Enums/returnStatus.dart';

/// Classe responsável por tratar os erros recebidos durante a execução do aplicativo
class ErrorHandler {
  static final ErrorHandler _singleton = ErrorHandler._internal();

  factory ErrorHandler() {
    return _singleton;
  }

  ErrorHandler._internal();

  /// Método responsável por retornar o status do erro
  ReturnStatus getErrorStatus(String erro) {
    ReturnStatus retorno = ReturnStatus.ERROR;
    if (erro.isNotEmpty) {
      for (int i = 0; i < ReturnStatus.values.length; i++) {
        if (erro == ReturnStatus.values[i].toString().split('.').last) {
          retorno = ReturnStatus.values[i];
          break;
        }
      }
    }
    return retorno;
  }

  /// Método responsável por retornar a mensagem específica do status passado por parâmetro
  String getErrorMessage(ReturnStatus error) {
    String mensagem = "";
    switch (error) {
      case ReturnStatus.SUCCESS:
        mensagem = "Sucesso.";
        break;
      case ReturnStatus.ERROR:
        mensagem = "Ocorreu um erro inesperado. Tente novamente.";
        break;
      case ReturnStatus.ERROR_WEAK_PASSWORD:
        mensagem = "A senha deve conter pelo menos 6 caracteres.";
        break;
      case ReturnStatus.ERROR_INVALID_EMAIL:
        mensagem = "Este e-mail é inválido.";
        break;
      case ReturnStatus.ERROR_EMAIL_ALREADY_IN_USE:
        mensagem = "Este e-mail já está cadastrado.";
        break;
      case ReturnStatus.ERROR_WRONG_PASSWORD:
        mensagem = "Senha ou usuário incorreto.";
        break;
      case ReturnStatus.ERROR_USER_NOT_FOUND:
        mensagem = "Senha ou usuário incorreto.";
        break;
      case ReturnStatus.ERROR_USER_DISABLED:
        mensagem = "Usuário desabilitado. Contate o suporte.";
        break;
      case ReturnStatus.ERROR_TOO_MANY_REQUESTS:
        mensagem =
            "Foram realizadas muitas requisições. Aguarde e tente novamente dentro de alguns instantes.";
        break;
      case ReturnStatus.ERROR_OPERATION_NOT_ALLOWED:
        mensagem = "Operação não permitida.";
        break;
      default:
        mensagem = "Ocorreu um erro inesperado. Tente novamente.";
        break;
    }
    return mensagem;
  }
}
