class Allergy{

  String title;
  bool isSelected;

  Allergy(this.title,  this.isSelected);

  Map <String, dynamic> toJson()=> {
        'title': title,
        'isSelected': isSelected 
      };
}