class League {
  int akuSeries = 0;
  int mikkoSeries = 0;
  int olliSeries = 0;

  int akuTotal = 0;
  int mikkoTotal = 0;
  int olliTotal = 0;

  int akuBestOfDay = 0;
  int mikkoBestOfDay = 0;
  int olliBestOfDay = 0;

  int get akuPoints {
    return akuSeries + akuTotal + akuBestOfDay;
  }

  int get mikkoPoints {
    return mikkoSeries + mikkoTotal + mikkoBestOfDay;
  }

  int get olliPoints {
    return olliSeries + olliTotal + olliBestOfDay;
  }
}
