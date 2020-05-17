import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inpay_app/Enums/returnStatus.dart';
import 'package:inpay_app/Models/usuario.dart';
import 'package:inpay_app/Utils/errorHandler.dart';

/// Classe abstrata que define os métodos relacionados ao serviço de banco de dados Cloud Firestore
abstract class BaseFirestore {
  String get collectionUsuarios;

  Future<ReturnStatus> criarUsuario(String userId, Usuario usuario);

  Future<Usuario> recuperarUsuario(String userId);
}

/// Classe Singleton que implementa a classe abstrata BaseFirestore
class Database implements BaseFirestore {
  static final Database _singleton = Database._internal();

  factory Database() {
    return _singleton;
  }

  Database._internal();

  final Firestore _db = Firestore.instance;

  Usuario usuarioLogado = Usuario();

  String get collectionUsuarios => "usuarios";

  /// Método responsável por criar um usuário no banco de dados
  @override
  Future<ReturnStatus> criarUsuario(String userId, Usuario usuario) async {
    ReturnStatus retorno = ReturnStatus.SUCCESS;
    await _db
        .collection(collectionUsuarios)
        .document(userId)
        .setData(usuario.toMap())
        .catchError((error) {
      retorno = ErrorHandler().getErrorStatus(error.code.toString());
    });
    return retorno;
  }

  /// Método responsável por recuperar os dados e retornar uma instância de usuário dado seu UID
  @override
  Future<Usuario> recuperarUsuario(String userId) async {
    Usuario user = Usuario();
    await _db
        .collection(collectionUsuarios)
        .document(userId)
        .get()
        .then((value) {
      user = Usuario.fromMap(value.data);
      usuarioLogado = user;
    });
    return user;
  }
}
