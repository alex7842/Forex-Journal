class Category {
  String thumbnail;
  String name;
  int noOfCourses;

  Category({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Add Journal',
    noOfCourses: 55,
    thumbnail: 'assets/images/icons/profit.png',
  ),
  Category(
    name: 'Dash Board',
    noOfCourses: 20,
    thumbnail: 'assets/images/icons/dashboard.png',
  ),
  Category(
    name: 'Market',
    noOfCourses: 16,
    thumbnail: 'assets/images/icons/crypto.png',
  ),
  Category(
    name: 'Reports',
    noOfCourses: 25,
    thumbnail: 'assets/images/icons/document.png',
  ),
];