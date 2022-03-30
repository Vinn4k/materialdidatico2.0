///RECEBE DADOS DA API DO GOOLEAUTH E RETORNA MENSSAGEM EM PORTUGUÊS
class AuthHanddler{

  String errorFilter(String error){
    switch(error){
      case "The password is invalid or the user does not have a password.":
       return "Usuário ou senha Incorreto";

      case  "There is no user record corresponding to this identifier. The user may have been deleted." :
        return "Usuário ou senha Incorreto";

      case "The email address is badly formatted.":
        return "E-mail Inválido";

      case "The user account has been disabled by an administrator.":
        return "Usuário desabilitado, por favor entre em contato com a escola";

      case "A network error (such as timeout, interrupted connection or unreachable host) has occurred.":
       return "Falha na Conexão";
      case "The email address is already in use by another account.":
        return "Email Já Cadastrado";
      case "Password should be at least 6 characters":
        return " A Senha Deve conter no minimo 6 dígitos";
      case "Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.":
        return "Usuário Bloqueado temporariamente, tente novamente em alguns minutos ";
    }
    return "";
  }

}