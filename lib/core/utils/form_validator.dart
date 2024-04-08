mixin Validator {
  static bool isEmailValid(String value) =>
      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value);

  static bool isUsernameValid(String value) => RegExp(
          r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{1,29}$')
      .hasMatch(value);

  static bool isDisplayNameValid(String value) =>
      value.length > 2 && value.length < 40;

  static bool isPasswordValid(String value) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$')
          .hasMatch(value);

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!isEmailValid(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least be 8 characters';
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Add at least one upper case character';
    } else if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Add at least one lower case character';
    } else if (!value.contains(RegExp(r'[@#.&,?]'))) {
      return 'Add at least one special character such as (@ # . , & ?)';
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Add at least one number';
    }
    return null;
  }

  // Confirm password validation
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value != password) {
      return 'Confirm password does not match';
    }
    return null;
  }

  // Name validation
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    } else if (value.length < 3) {
      return 'Usernames should at least be 2 characters';
    } else if (value.startsWith('.')) {
      return 'You can\'t start your username with a period';
    } else if (value.endsWith('.')) {
      return 'You can\'t end your username with a period';
    } else if (!isUsernameValid(value)) {
      return 'Please enter a valid username';
    }
    return null;
  }

  // Name validation
  String? validateDisplayName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Display name is required';
    } else if (value.length < 3) {
      return 'Your name should at least be 3 characters';
    }
    return null;
  }
}
