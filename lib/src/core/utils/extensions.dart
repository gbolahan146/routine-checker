// ignore: import_of_legacy_library_into_null_safe

extension StringExtension on String {
  String get svg => 'assets/images/svgs/$this.svg';
  String get png => 'assets/images/pngs/$this.png';

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

}
