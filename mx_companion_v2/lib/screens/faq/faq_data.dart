class Faqs{
  Faqs(
      this.title,
      this.body,
      [this.isExpanded = false]
      );
  String title;
  String body;
  bool isExpanded;
}

List<Faqs> getFaqs() {
  return [
    Faqs('FAQ 1', 'This is the first FAQ',),
    Faqs('FAQ 2', 'This is the second FAQ'),
    Faqs('FAQ 3', 'This is the third FAQ'),
    Faqs('FAQ 4', 'This is the first FAQ',),
    Faqs('FAQ 5', 'This is the second FAQ'),
    Faqs('FAQ 6', 'This is the third FAQ'),
    Faqs('FAQ 7', 'This is the first FAQ',),
    Faqs('FAQ 8', 'This is the second FAQ'),
    Faqs('FAQ 9', 'This is the third FAQ'),
  ];
}