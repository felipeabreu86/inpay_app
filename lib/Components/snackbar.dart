library snackbar;

import 'package:flutter/material.dart';

/// Snackbar dinâmico

Widget buildSnackBar(String mensagem, int segundos) {
  return SnackBar(
    duration: Duration(seconds: segundos),
    content: Text(mensagem),
  );
}

/// Snackbars estáticos

final snackbarConexao = SnackBar(
  duration: Duration(seconds: 3),
  content: Text(
      "Verifique se a conexão com a internet está funcionando corretamente."),
);

final snackbarPreencherCampos = SnackBar(
  duration: Duration(seconds: 3),
  content: Text("Por favor, preencha todos os campos."),
);

final snackbarUsuarioCadastrado = SnackBar(
  duration: Duration(seconds: 2),
  content: Text("Cadastro realizado com sucesso."),
);

final snackbarEmailRecuperacaoEnviado = SnackBar(
  duration: Duration(seconds: 2),
  content: Text("E-mail de recuperação de senha enviado com sucesso!"),
);