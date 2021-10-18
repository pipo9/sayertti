import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<TextAlign> directions = [TextAlign.left, TextAlign.right];
List<String> languages = ["FRANÇAIS", "العربية"]; // to store language of the app

/// texts in french and arabic in Json format
var texts =
'''{
  "FRANÇAIS" : {
    "email" : "email",
    "code" : "taper le code",
    "name" : "Nom complet",
    "phone" : "Telephone",
    "password" : "mot de pass",
    "signIN" : "S'IDENTIFIER",
    "signUP" : "S'INSCRIRE",
    "forget" : "Oubile le mot de pass ?",
    "send" : "Envoyer",
    "search": "Recherche",
    "all" : "Tous",
    "profile" : "Profile",
    "edit" : "Éditer",
    "update" : "Mettre à jour",
    "address" : "Address",
    "orders" : "Orders",
    "id" : "Order id",
    "price" : "prix",
    "items" : "Items",
    "settings" : "Parametres",
    "privacy" : "Politique de confidentialité",
    "about" : "À propos de nous",
    "support" : "Support",
    "logout" : "Se déconnecter",
    "language" : "Language",
    "details" : "Détails",
    "cart" : "Panier",
    "add" : "Ajouter",
    "nbr" : "Quantite",
    "request" : "Demander",
    "check" : "Vérifiez et payez vos articles",
    "nborder" : "Nombre",
    "total" : "Total",
    "done" : "D'acc",
    "ok" : "Confirmer",
    "delete" : "Supprimer",
    "R-pass":"Mot de passe doit être de 8 caractères ou plus",
    "E-pass":"Les mots de passe doivent être identiques",
    "B-email":"l'e-mail est de mauvais format",
    "E-name":"les champs ne doit pas être vide",
    "E-connection":"pas de connection",
    "E-error":"un erreur se produit",
    "invalid-pass":"Mot de passe incorrect",
    "x-user":"utilisateur non trouvé"
    },
  "العربية" : {
    "email": "البريد الإلكتروني",
    "code" : "أدخل الرمز",
    "name" : " الإسم الكامل",
    "phone" : "الهاتف",
    "password" : "القن السري",
    "signIN" : "دخول",
    "signUP" : "تسجيل",
    "forget" : "نسيت كلمت السر ؟",
    "send" :"أرسل",
    "search": "البحت",
    "all" : "الكل",
    "profile" : "الحساب",
    "address" : "العنوان",
    "edit" : "تعديل",
    "update" : "تحديث",
    "orders" : "الطلبات",
    "id" : "رقم الطلب",
    "price" : "التمن ",
    "items" : "العدد ",
    "settings" : "الإعدادات",
    "privacy" : "سياسة الخاصوصية",
    "about" : "حولنا",
    "support" : "الدعم",
    "logout" : "تسجيل خروج",
    "language" : "اللغة",
    "details" : "التفاصيل",
    "cart" : "السلة",
    "add" : "أضف",
    "nbr" : "العدد",
    "request" : "طلب",
    "check" : "تحقق ودفع البنود الخاصة بك",
    "nborder" : "العدد",
    "total" : "المجموع",
    "done" : "تمام",
    "ok" : "تأكيد",
   "delete" : "مسخ",
   "R-pass":"يجب أن تكون كلمة المرور 8 أحرف أو أكثر",
   "E-pass":"يجب أن تكون كلمات المرور متطابقة",
   "B-email":"البريد الإلكتروني بتنسيق خاطئ",
   "E-name":"يجب ألا يكون مكان فارغًا",
   "E-connection":"لا يوجد اتصال",
   "E-error":"حدث خطأ",
   "invalid-pass":"رمز مرور خاطئ",
   "x-user":"لم يتم العثور على المستخدم"

  }
}''';

//// from json to map
JsonDecoder jsonDecoder = new JsonDecoder();
dynamic toMap() {
  var mesLanguages = jsonDecoder.convert(texts);
  return mesLanguages;
}

//to store language and direction of the text
int language = 0;

///// save language and direction
saveValueLanguage(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('Direction', value);
  await getValueLanguage();
}

///// get language and direction
getValueLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  language = prefs.getInt('Direction')==null? 0:prefs.getInt('Direction');
}
