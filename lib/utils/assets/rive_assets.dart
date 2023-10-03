enum RiveAssets {
  bluePlanet('blue_planet', 'assets/animated/569-6666-blue-planet.riv'),
  loginCharacter('login_character', 'assets/animated/login_character.riv'),
  iphoneHero('iphone_hero', 'assets/animated/iphone_hero.riv');

  const RiveAssets(this.name, this.path);
  final String name;
  final String path;
}
