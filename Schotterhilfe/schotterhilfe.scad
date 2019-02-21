$fn=100;

module schotterhilfe() {
  points=[[0,6], [5.8,6], [5.8,8], [7.2,8], [7.2,6], [14,6], [21.5,0], [25,0], [25,30], [0,30]];
  polygon(points);
  mirror([1,0,0]) {
  polygon(points);
  };
};

schotterhilfe();