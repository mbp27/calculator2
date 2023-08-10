class Utils {
  Utils._();

  /// Check if is number by input string
  static bool isNumber(String input) {
    return RegExp('^[0-9]').hasMatch(input);
  }

  /// Check if is number by input string
  static bool isParentheses(String input) {
    return input.contains('(') || input.contains(')');
  }

  /// Formatting amount to give ',' on 3 zero
  static String formatAmount(String price) {
    String amount = price;
    bool isNegative = amount.contains('-');
    if (isNegative) {
      amount = amount.replaceAll('-', '');
    }
    bool isDecimal = amount.contains('.');
    int count = isDecimal ? amount.lastIndexOf('.') - 1 : (amount.length - 1);
    String decimal = isDecimal ? amount.substring(count + 1) : '';
    String amountInText = "";
    int counter = 0;
    for (int i = count; i >= 0; i--) {
      counter++;
      String str = amount[i];
      if ((counter % 3) != 0 && i != 0) {
        amountInText = "$str$amountInText";
      } else if (i == 0) {
        amountInText = "$str$amountInText";
      } else {
        amountInText = ",$str$amountInText";
      }
    }
    return (isNegative ? '-' : '') + (amountInText + decimal).trim();
  }
}
