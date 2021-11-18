class Validate {
  static String passwordValidate(String pwd) {
    if (pwd.isEmpty || pwd == null || pwd == '') {
      return 'Please enter password.';
    }
    if (pwd.length < 6) return 'Required at least 6 chars.';
    return null;
  }

  static String phoneValidate(String value) {
    if (value.trim().isEmpty ||
        value.trim() == '' ||
        value.trim().length == 0) {
      return 'Please enter phone number';
    }
    if (value.trim().length < 9 || value.trim().length > 11) {
      return 'Valid phone number from 9-11 character';
    }
    return null;
  }

  static String notEmptyValidate(String value) {
    return value.trim().isEmpty ? 'Please fill this field' : null;
  }

  static String reEnterPasswordValidate(String value, String value2) {
    if (value.trim().isEmpty) return 'Please fill this field';

    if (value.trim().length < 6) return 'Required at least 6 chars.';
    if (value.trim() != value2.trim()) return 'New password does not match.';
    return null;
  }

  static String emailValidate(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  static String displayNameValidate(String value) {
    if (value.isEmpty)
      return 'Display name is requried';
    else if (value.length > 16) return 'Valid display name length is 16 chars.';
    return null;
  }
}
