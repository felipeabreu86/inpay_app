import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inpay_app/Enums/returnStatus.dart';
import 'package:inpay_app/Models/usuario.dart';
import 'package:inpay_app/Services/firestore.dart';
import 'package:inpay_app/Utils/errorHandler.dart';

/// Classe abstrata que define os métodos relacionados à autenticação do usuário
abstract class BaseAuth {
  Future<ReturnStatus> signIn(String email, String password);

  Future<ReturnStatus> signInGoogle();

  Future<ReturnStatus> signUp(Usuario usuario);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<void> signOutGoogle();

  Future<bool> isEmailVerified();

  Future<ReturnStatus> sendPasswordResetEmail(String email);
}

/// Classe Singleton que implementa a classe abstrata BaseAuth
class Auth implements BaseAuth {
  static final Auth _singleton = Auth._internal();

  factory Auth() {
    return _singleton;
  }

  Auth._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Realiza login via e-mail e senha
  Future<ReturnStatus> signIn(String email, String password) async {
    ReturnStatus retorno = ReturnStatus.ERROR;
    AuthResult result = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      retorno = ErrorHandler().getErrorStatus(error.code.toString());
    });
    String userId = result?.user?.uid?.toString() ?? null;
    if (userId != null && userId.length > 0) {
      retorno = ReturnStatus.SUCCESS;
    }
    return retorno;
  }

  /// Cadastra um novo usuário via e-mail e senha
  Future<ReturnStatus> signUp(Usuario usuario) async {
    ReturnStatus retorno = ReturnStatus.SUCCESS;
    await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) async {
      retorno = await Database().criarUsuario(firebaseUser.user.uid, usuario);
    }).catchError((error) {
      retorno = ErrorHandler().getErrorStatus(error.code.toString());
    });
    return retorno;
  }

  /// Retorna o usuário autenticado no aplicativo
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  /// Realiza a desautenticação do usuário que logou via e-mail
  Future<void> signOut() async {
    Database().usuarioLogado = Usuario();
    return _firebaseAuth.signOut();
  }

  /// Envia um e-mail de verificacao ao usuário
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  /// Retorna se o e-mail foi verificado
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  /// Envia um e-mail ao usuário para reconfiguração da senha
  Future<ReturnStatus> sendPasswordResetEmail(String email) async {
    ReturnStatus retorno = ReturnStatus.SUCCESS;
    await _firebaseAuth
        .sendPasswordResetEmail(email: email)
        .catchError((error) {
      retorno = ErrorHandler().getErrorStatus(error.code.toString());
    });
    return retorno;
  }

  /// Realiza login do usuário via Google
  Future<ReturnStatus> signInGoogle() async {
    ReturnStatus retorno = ReturnStatus.SUCCESS;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid);
    } catch (error) {
      print("Google Login Error: ${error.code}");
      retorno = ErrorHandler().getErrorStatus(error.code.toString());
    }
    return retorno;
  }

  /// Realiza a desautenticação do usuário que logou via Google
  Future<void> signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}
