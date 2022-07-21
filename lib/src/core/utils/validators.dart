var regex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class Validators {
  static String? validateField(String? value) {
    if (value!.isEmpty) {
      return "Field cannot be empty";
    } else {
      return null;
    }
  }


  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email cannot be empty";
    } else if (!regex.hasMatch(email)) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }


  static String? validateFullName(String? fullName) {
    if (fullName != null && fullName.isEmpty) {
      return 'Fullname field cannot be empty';
    }

    if (fullName != null && fullName.split(' ').length < 2) {
      return 'Fullname field should contain first and last name';
    }
    return null;
  }

}
