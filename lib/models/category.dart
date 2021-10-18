

class Category{
 String nameFr;
 String nameAr;
 String id;

  Category(
      this.id,
      this.nameFr,
      this.nameAr
      );

 factory Category.fromJson(Map<String, dynamic> category) {
   return Category(
       category["id"],
       category['nameFr'],
       category['nameAr']
   );
 }
}