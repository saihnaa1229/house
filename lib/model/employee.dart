class Employee {
  final String name;
  final String img;
  final int employeeId;
  final String category;
  final double salary;
  final double rating;
  final int review;

  Employee(
      {required this.category,
      required this.name,
      required this.employeeId,
      required this.img,
      required this.rating,
      required this.review,
      required this.salary});
}
