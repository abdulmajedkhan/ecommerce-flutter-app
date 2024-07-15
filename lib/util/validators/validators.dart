class NValidators {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regular expression for email
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid Email Address';
    }
    return null;
  }

  static String? validPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // Minimum password length check
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    // Upper case check
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    // Number check
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    // Special character check
    if (!RegExp(r'[!@#$%^&*]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }


  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number  is required';
    }
    //Regular Expression for 10 digit phone Number
    final phoneRegExp = RegExp(r'^\d{11}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid Phone number';
    }

    return null;
  }
}
