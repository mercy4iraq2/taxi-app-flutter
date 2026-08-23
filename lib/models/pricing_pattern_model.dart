/// نموذج نمط التسعير المفصل
class PricingPattern {
  final String patternId; // "1", "2", "3", "4", "5", "6"
  final String name; // اسم النمط
  final String description; // وصف الحساب
  final String descriptionAr;
  final String formula; // الصيغة الرياضية
  final String formulaAr;

  PricingPattern({
    required this.patternId,
    required this.name,
    required this.description,
    required this.descriptionAr,
    required this.formula,
    required this.formulaAr,
  });

  factory PricingPattern.pattern1() {
    return PricingPattern(
      patternId: '1',
      name: 'By Minute Only',
      description: 'Price = Minute × Per Minute Rate',
      descriptionAr: 'السعر = الدقيقة × سعر الدقيقة',
      formula: 'Price = Duration(min) × Rate/min',
      formulaAr: 'السعر = المدة(دقيقة) × سعر/دقيقة',
    );
  }

  factory PricingPattern.pattern2() {
    return PricingPattern(
      patternId: '2',
      name: 'Base + By Minute',
      description: 'Price = Base Fare + (Minute × Per Minute Rate)',
      descriptionAr: 'السعر = اجرة الانطلاق + (الدقيقة × سعر الدقيقة)',
      formula: 'Price = BaseFare + Duration(min) × Rate/min',
      formulaAr: 'السعر = اجرة الانطلاق + المدة(دقيقة) × سعر/دقيقة',
    );
  }

  factory PricingPattern.pattern3() {
    return PricingPattern(
      patternId: '3',
      name: 'Base + By Minute (Peak Hours)',
      description: 'Price = Base Fare + (Minute × Per Minute Rate × Peak Multiplier)',
      descriptionAr: 'السعر = اجرة الانطلاق + (الدقيقة × سعر الدقيقة × معامل الذروة)',
      formula: 'Price = BaseFare + Duration(min) × Rate/min × PeakMultiplier',
      formulaAr: 'السعر = اجرة الانطلاق + المدة(دقيقة) × سعر/دقيقة × معامل الذروة',
    );
  }

  factory PricingPattern.pattern4() {
    return PricingPattern(
      patternId: '4',
      name: 'Base + Distance + Time',
      description: 'Price = Base Fare + (Distance × Per KM) + (Minute × Per Minute Rate)',
      descriptionAr: 'السعر = اجرة الانطلاق + (المسافة × سعر الكم) + (الدقيقة × سعر الدقيقة)',
      formula: 'Price = BaseFare + Distance(km) × Rate/km + Duration(min) × Rate/min',
      formulaAr: 'السعر = اجرة الانطلاق + المسافة(كم) × سعر/كم + المدة(دقيقة) × سعر/دقيقة',
    );
  }

  factory PricingPattern.pattern5() {
    return PricingPattern(
      patternId: '5',
      name: 'By Minute (No Base)',
      description: 'Price = Minute × Per Minute Rate',
      descriptionAr: 'السعر = الدقيقة × سعر الدقيقة',
      formula: 'Price = Duration(min) × Rate/min',
      formulaAr: 'السعر = المدة(دقيقة) × سعر/دقيقة',
    );
  }

  factory PricingPattern.pattern6() {
    return PricingPattern(
      patternId: '6',
      name: 'By Minute + Base',
      description: 'Price = (Minute × Per Minute Rate) + Base Fare',
      descriptionAr: 'السعر = (الدقيقة × سعر الدقيقة) + اجرة الانطلاق',
      formula: 'Price = Duration(min) × Rate/min + BaseFare',
      formulaAr: 'السعر = المدة(دقيقة) × سعر/دقيقة + اجرة الانطلاق',
    );
  }

  static List<PricingPattern> getAllPatterns() {
    return [
      PricingPattern.pattern1(),
      PricingPattern.pattern2(),
      PricingPattern.pattern3(),
      PricingPattern.pattern4(),
      PricingPattern.pattern5(),
      PricingPattern.pattern6(),
    ];
  }

  static PricingPattern getPatternById(String patternId) {
    final patterns = getAllPatterns();
    return patterns.firstWhere(
      (p) => p.patternId == patternId,
      orElse: () => PricingPattern.pattern4(),
    );
  }
}
