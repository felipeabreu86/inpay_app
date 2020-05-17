import 'dart:convert';

/// Modelo contendo os dados do usuário
class Usuario {
  String idUsuario;
  String nome;
  String email;
  String senha;
  String telefone;
  String urlImagem;
  String cpf;

  Usuario({
    this.idUsuario,
    this.nome,
    this.email,
    this.senha,
    this.telefone,
    this.urlImagem,
    this.cpf,
  });

  bool get isLoginFieldsFilled {
    return email.isNotEmpty && senha.isNotEmpty;
  }

  bool get isSignUpFieldsFilled {
    return nome.isNotEmpty &&
        email.isNotEmpty &&
        senha.isNotEmpty &&
        telefone.isNotEmpty;
  }

  Usuario copyWith({
    String idUsuario,
    String nome,
    String email,
    String telefone,
    String urlImagem,
    String cpf,
  }) {
    return Usuario(
      idUsuario: idUsuario ?? this.idUsuario,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      urlImagem: urlImagem ?? this.urlImagem,
      cpf: cpf ?? this.cpf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'urlImagem': urlImagem,
      'cpf': cpf,
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Usuario(
      idUsuario: map['idUsuario'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      urlImagem: map['urlImagem'],
      cpf: map['cpf'],
    );
  }

  String toJson() => json.encode(toMap());

  static Usuario fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(idUsuario: $idUsuario, nome: $nome, email: $email, telefone: $telefone, urlImagem: $urlImagem, cpf: $cpf)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Usuario &&
        o.idUsuario == idUsuario &&
        o.nome == nome &&
        o.email == email &&
        o.telefone == telefone &&
        o.urlImagem == urlImagem &&
        o.cpf == cpf;
  }

  @override
  int get hashCode {
    return idUsuario.hashCode ^
        nome.hashCode ^
        email.hashCode ^
        telefone.hashCode ^
        urlImagem.hashCode ^
        cpf.hashCode;
  }
}
