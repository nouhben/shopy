enum Images {
  onBorading1('image1', 'assets/images/image1.png'),
  onBorading2('image2', 'assets/images/image2.png'),
  onBorading3('image3', 'assets/images/image3.png'),
  onBorading4('image4', 'assets/images/image4.png');

  const Images(this.name, this.path);
  final String name;
  final String path;
}
