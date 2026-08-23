# 📱 Taxi App - Flutter Implementation Guide

## Quick Start Guide - دليل البدء السريع

### 1. المتطلبات الأساسية
```bash
Flutter SDK >= 3.0.0
Dart >= 3.0.0
Android Studio / Xcode
Visual Studio Code (Optional)
```

### 2. التثبيت والإعداد

#### الخطوة 1: استنساخ المستودع
```bash
git clone https://github.com/mercy4iraq2/taxi-app-flutter.git
cd taxi-app-flutter
```

#### الخطوة 2: تثبيت المكتبات
```bash
flutter pub get
```

#### الخطوة 3: إعداد المتغيرات البيئية
```bash
cp .env.example .env
# ثم قم بتعديل قيم المتغيرات في .env
```

#### الخطوة 4: تشغيل التطبيق
```bash
# لتشغيل على محاكي Android
flutter run -d android

# لتشغيل على محاكي iOS
flutter run -d ios
```

---

## 📁 هيكل المشروع

```
lib/
├── main.dart                    # نقطة الدخول الرئيسية
├── config/
│   ├── app_theme.dart           # الألوان والأنماط
│   ├── app_constants.dart       # الثوابت العامة
│   ├── routes.dart              # تعريف المسارات
│   └── index.dart               # إعادة تصدير
├── models/
│   ├── user_model.dart          # نموذج المستخدم
│   ├── driver_model.dart        # نموذج السائق
│   ├── passenger_model.dart     # نموذج المسافر
│   ├── trip_model.dart          # نموذج الرحلة
│   ├── payment_model.dart       # نموذج الدفع
│   ├── rating_model.dart        # نموذج التقييم
│   └── index.dart               # إعادة تصدير
├── services/
│   ├── api_service.dart         # خدمة الـ API
│   ├── location_service.dart    # خدمة الموقع
│   ├── socket_service.dart      # خدمة الـ WebSocket
│   ├── secure_storage_service.dart # التخزين الآمن
│   └── index.dart               # إعادة تصدير
├── providers/
│   └── auth_provider.dart       # إدارة حالة التحقق
├── screens/
│   ├── splash/
│   ├── auth/
│   ├── passenger/
│   ├── driver/
│   ├── admin/
│   └── index.dart               # إعادة تصدير
├── widgets/
│   ├── custom_button.dart       # زر مخصص
│   ├── custom_text_field.dart   # حقل نص مخصص
│   └── index.dart               # إعادة تصدير
├── utils/
│   ├── validators.dart          # دوال التحقق
│   ├── formatters.dart          # دوال التنسيق
│   ├── currency_formatter.dart  # تنسيق العملات
│   ├── extensions.dart          # توسيعات String
│   ├── logger.dart              # نظام التسجيل
│   └── index.dart               # إعادة تصدير
└── assets/
    ├── images/
    ├── icons/
    ├── fonts/
    └── animations/
```

---

## 🔐 المتغيرات البيئية

قم بإنشاء ملف `.env` مع البيانات التالية:

```env
# API
API_BASE_URL=https://api.taxiapp.com/v1
SOCKET_URL=https://socket.taxiapp.com

# Google Maps
GOOGLE_MAPS_API_KEY=your_key_here

# Firebase
FIREBASE_PROJECT_ID=taxi-app

# Stripe
STRIPE_PUBLISHABLE_KEY=your_key_here
```

---

## 📱 الشاشات الرئيسية

### للمسافر (Passenger)
- ✅ Splash Screen - شاشة البداية
- ✅ Login/Signup - التسجيل
- ✅ Home Screen - الصفحة الرئيسية
- ✅ Ride Details - تفاصيل الرحلة
- ✅ Payment - الدفع
- ✅ Rating - التقييم
- ✅ Profile - الملف الشخصي
- ✅ Trip History - سجل الرحلات

### للسائق (Driver)
- ✅ Driver Home - الصفحة الرئيسية
- ✅ Driver Navigation - الملاحة
- ✅ Driver Earnings - سجل الأرباح
- ✅ Driver Profile - الملف الشخصي

### للإدارة (Admin)
- ✅ Admin Dashboard - لوحة التحكم
- ✅ Users Management - إدارة المستخدمين
- ✅ Pricing Management - إدارة الأسعار
- ✅ Reports & Analytics - التقارير

---

## 🛠️ تطوير الميزات الجديدة

### إضافة خدمة جديدة

```dart
// services/new_service.dart
class NewService {
  static final NewService _instance = NewService._internal();

  factory NewService() {
    return _instance;
  }

  NewService._internal();

  Future<void> initialize() async {
    // التهيئة
  }
}
```

### إضافة نموذج جديد

```dart
// models/new_model.dart
class NewModel {
  final String id;
  final String name;

  NewModel({required this.id, required this.name});

  factory NewModel.fromJson(Map<String, dynamic> json) {
    return NewModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
```

### إضافة شاشة جديدة

```dart
// screens/new/new_screen.dart
import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Screen')),
      body: Center(child: const Text('Your content here')),
    );
  }
}
```

---

## 🧪 الاختبار

### تشغيل جميع الاختبارات
```bash
flutter test
```

### اختبار ملف محدد
```bash
flutter test test/services/api_service_test.dart
```

### اختبار مع التغطية
```bash
flutter test --coverage
```

---

## 🚀 البناء والنشر

### بناء Android
```bash
# APK
flutter build apk --release

# App Bundle
flutter build appbundle --release
```

### بناء iOS
```bash
flutter build ios --release
```

---

## 🔑 أفضل الممارسات

### 1. الالتزام بهيكل المشروع
- استخدم المجلدات المنظمة
- اتبع نمط المجلد الواحد للشاشة
- استخدم ملفات الفهرسة (index.dart)

### 2. إدارة الحالة (State Management)
```dart
// استخدم Provider للحالة البسيطة
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
```

### 3. معالجة الأخطاء
```dart
try {
  final result = await apiService.get('/endpoint');
} catch (e) {
  AppLogger.error('Error occurred', e);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(e.toString())),
  );
}
```

### 4. التنسيق (Formatting)
- استخدم دوال Formatter للتواريخ والعملات
- تابع معايير التسمية
- أضف تعليقات واضحة

---

## 📚 الموارد المفيدة

- [Flutter Official Docs](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
- [Firebase for Flutter](https://firebase.flutter.dev/)

---

## 🤝 المساهمة

1. Fork المستودع
2. إنشاء فرع جديد: `git checkout -b feature/NewFeature`
3. Commit التغييرات: `git commit -m 'Add NewFeature'`
4. Push إلى الفرع: `git push origin feature/NewFeature`
5. فتح Pull Request

---

## 📧 التواصل

- البريد الإلكتروني: support@taxiapp.com
- الموقع: https://taxiapp.com
- المشاكل: [GitHub Issues](https://github.com/mercy4iraq2/taxi-app-flutter/issues)

---

## 📄 الترخيص

هذا المشروع مرخص تحت [MIT License](LICENSE)

---

**تم إنشاؤه بـ ❤️ بواسطة فريق تطوير التطبيقات الذكية**
