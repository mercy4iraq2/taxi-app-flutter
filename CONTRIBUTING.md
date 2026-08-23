# Contributing to Taxi App

## 🤝 أحنا نرحب بمساهمتك!

شكراً لاهتمامك بالمساهمة في Taxi App. هذا الملف يحتوي على إرشادات لكيفية المساهمة.

## 📋 قبل البدء

### اقرأ الوثائق
- اقرأ [README.md](README.md)
- اقرأ [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)
- افهم هيكل المشروع

## 🐛 الإبلاغ عن الأخطاء

عند الإبلاغ عن خطأ، يرجى تضمين:

1. **وصف واضح** للمشكلة
2. **خطوات الإعادة** (How to reproduce)
3. **السلوك المتوقع** (Expected behavior)
4. **السلوك الفعلي** (Actual behavior)
5. **الصور أو الفيديوهات** إذا أمكن
6. **معلومات النظام** (OS, Flutter version, etc)

### مثال
```
Title: Login button not responding on Android

Description:
When clicking the login button on Android devices, nothing happens.

Steps to reproduce:
1. Install app on Android device
2. Navigate to login screen
3. Click login button

Expected behavior:
The app should validate the form and submit the login request.

Actual behavior:
The button click is not registered.

Environment:
- Flutter: 3.10.0
- Dart: 3.0.0
- Android: 13
```

## ✨ اقتراح ميزات جديدة

### خطوات الاقتراح
1. تحقق من وجود اقتراح مشابه
2. وصف الميزة بوضوح
3. شرح الفائدة
4. إذا أمكن، قدم أمثلة

### مثال
```
Title: Add social media login options

Description:
Currently, the app only supports email/phone login. It would be 
great to support social login methods.

Benefits:
- Faster registration process
- Better user experience
- Increased user retention

Implementation:
- Google Sign-In
- Facebook Login
- Apple Sign-In
```

## 🔧 إرسال Pull Request

### 1. تحضير البيئة
```bash
git clone https://github.com/mercy4iraq2/taxi-app-flutter.git
cd taxi-app-flutter
flutter pub get
```

### 2. إنشاء فرع جديد
```bash
git checkout -b feature/your-feature-name
# أو للأخطاء
git checkout -b fix/bug-name
```

### 3. كتابة الكود
- اتبع معايير الكود (Code Style)
- أضف اختبارات إذا أمكن
- اكتب رسائل commit واضحة

### 4. معايير الكود

#### التسمية (Naming)
```dart
// Good
class PassengerHomeScreen {}
final apiService = ApiService();
void onLoginPressed() {}

// Bad
class PassengerScreen {}
final api = ApiService();
void onPressed() {}
```

#### التنسيق (Formatting)
```dart
// استخدم flutter format
flutter format lib/
```

#### التحليل (Linting)
```dart
// تحقق من المشاكل المحتملة
flutter analyze
```

### 5. الاختبارات
```dart
// أضف اختبارات لميزتك
test('User can login successfully', () async {
  // arrange
  // act
  // assert
});
```

### 6. رسالة الـ Commit
```bash
# Good
git commit -m "feat: Add social media login support"
git commit -m "fix: Fix login button not responding on Android"
git commit -m "docs: Update README with new features"

# Bad
git commit -m "updated stuff"
git commit -m "fix bugs"
```

### 7. Push والـ Pull Request
```bash
git push origin feature/your-feature-name
```

ثم انتقل إلى GitHub وفتح Pull Request مع:
- **عنوان واضح** يصف الميزة/الإصلاح
- **وصف مفصل** للتغييرات
- **ربط الـ Issues** ذات الصلة (إن وجدت)
- **صور/فيديوهات** إذا كانت مناسبة

## 📝 معايير القبول

### يجب أن يحتوي PR على:
- ✅ كود يتبع معايير المشروع
- ✅ لا توجد مشاكل في flutter analyze
- ✅ جميع الاختبارات تمر بنجاح
- ✅ رسائل commit واضحة
- ✅ وثائق محدثة (إذا لزم الأمر)
- ✅ لا توجد تعارضات مع main branch

## 📚 إرشادات إضافية

### كتابة الاختبارات
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('Shows loading indicator when submitting', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      expect(find.byType(CircularProgressIndicator), findsNothing);
      
      await tester.tap(find.byText('Login'));
      await tester.pump();
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
```

### التوثيق (Documentation)
```dart
/// حساب التكلفة التقديرية للرحلة
/// 
/// [distance] - المسافة بالكيلومتر
/// [duration] - المدة بالدقائق
/// 
/// Returns: التكلفة المقدرة
double calculateEstimatedFare(double distance, double duration) {
  return (distance * perKmRate) + (duration * perMinRate);
}
```

## 🎯 مجالات يمكنك المساهمة فيها

- 🐛 **إصلاح الأخطاء**: ابحث عن issues مع label "bug"
- ✨ **ميزات جديدة**: ابحث عن issues مع label "enhancement"
- 📖 **التوثيق**: تحسين الـ README والتعليقات
- 🧪 **الاختبارات**: زيادة تغطية الاختبارات
- 🎨 **تحسين الواجهة**: تحسين UX/UI

## ❓ أسئلة؟

إذا كان لديك أي أسئلة:
- افتح Discussion في GitHub
- أرسل بريد إلى support@taxiapp.com
- اتصل بنا عبر المشروع

---

شكراً مرة أخرى على مساهمتك! 🙏
