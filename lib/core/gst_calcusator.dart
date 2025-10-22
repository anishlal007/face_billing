class GstCalculator {
  /// Calculates the final price and tax components based on inclusive/exclusive tax type.
  /// taxType = 0 is inclusive (originalAmount already includes tax).
  /// taxType = 1 is exclusive (tax is added to the amount).class GstCalculator {
  /// Calculates the final price and tax components based on inclusive/exclusive tax type.
  /// taxType = 0 is inclusive (originalAmount already includes tax).
  /// taxType = 1 is exclusive (tax is added to the amount).
  Map<String, double> calculate({
    required double originalAmount,
    required double discountPercentage,
    required double gstPercentage,
    required int taxType,
    // The redundant/misspelled 'gstPersantage' parameter has been removed.
  }) {
    // Convert percentage to a factor for easier calculation
    final double gstFactor = gstPercentage / 100;

    double baseAmount;

    if (taxType == 1) {
      baseAmount = originalAmount / (1 + gstFactor);
    } else {
      baseAmount = originalAmount;
    }

    final double discountAmount = baseAmount * (discountPercentage / 100);
    final double taxableValue = baseAmount - discountAmount;

    final double gstAmount = taxableValue * gstFactor;

    final double netRate = taxableValue + gstAmount;
    final double beforTaxAmount = originalAmount - discountAmount;
    return {
      'baseAmount': baseAmount, // The amount before discount (tax excluded)
      'discountAmount': discountAmount,
      'taxableValue':
          taxableValue, // The amount after discount, before tax addition
      'gstAmount': gstAmount,
      'netRate': netRate, // The final amount the customer pays
      'beforTaxAmount': beforTaxAmount,
    };
  }
}
