import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu email';
  }
  if (!email.isEmail) {
    return 'Digite um e-mail válido';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha';
  }
  if (password.length < 7) {
    return 'Digite uma senha com pelo menos 7 caracteres';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmail) {
    return 'Digite um nome';
  }

  final names = name.split(' ');

  if (names.length == 1) {
    return 'Digite seu nome completo';
  }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmail) {
    return 'Digite um celular';
  }

  if (!phone.isPhoneNumber || phone.length < 14) {
    return 'Digite um número válido';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmail) {
    return 'Digite um celular';
  }

  if (!cpf.isCpf) {
    return 'Digite um cpf válido';
  }
  return null;
}
