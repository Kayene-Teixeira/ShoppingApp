class AuthException implements Exception {
  final String key;
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'E-mail já cadastrado!',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente. Tente mais tarde!',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado!',
    'INVALID_PASSWORD': 'Senha informada é inválida!',
    'USER_DISABLED': 'A conta do usuário foi desabilitada!',
  };

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'O e-mail ou senha informados são inválidos!';
  }
}
