// Determines if 2 finite vectors intersect or not
function areIntersecting(
  [[v1x1, v1y1], [v1x2, v1y2]], // vector 1
  [[v2x1, v2y1], [v2x2, v2y2]] // vector 2
) {
  let a1 = v1y2 - v1y1;
  let b1 = v1x1 - v1x2;
  let c1 = (v1x2 * v1y1) - (v1x1 * v1y2);
  const f1 = (x, y) => a1 * x + b1 * y + c1;

  let v1d1 = f1(v2x1, v2y1);
  let v1d2 = f1(v2x2, v2y2);

  if (
    (v1d1 > 0 && v1d2 > 0) ||
    (v1d1 < 0 && v1d2 < 0)
  ) return false;

  let a2 = v2y2 - v2y1;
  let b2 = v2x1 - v2x2;
  let c2 = (v2x2 * v2y1) - (v2x1 * v2y2);
  const f2 = (x, y) => a2 * x + b2 * y + c2;

  let v2d1 = f2(v1x1, v1y1);
  let v2d2 = f2(v1x2, v1y2);

  if (
    (v2d1 > 0 && v2d2 > 0) ||
    (v2d1 < 0 && v2d2 < 0)
  ) return false;

  if (
    (a1 * b2) - (a2  * b1) === 0
  ) return true; // collinear

  return true;
}

// Return true if point is inside poly, and false if it is not
function pointInPoly(poly, [px, py]) {
  let xMin = Infinity;
  let xMax = -Infinity;
  let yMin = Infinity;
  let yMax = -Infinity;
  poly.forEach(([px, py]) => {
    xMin = Math.min(xMin, px);
    xMax = Math.max(xMax, px);
    yMin = Math.min(yMin, py);
    yMax = Math.max(yMax, py);
  });

  if (
    px < xMin || px > xMax ||
    py < yMin || py > yMax
  ) return false;

  let e = (xMax - xMin) / 100;
  let ray = [
    [xMin - e, py],
    [px, py]
  ];

  let intersections = 0;
  for (let i = 0; i < poly.length; i++) {
    let side = [
      poly[i],
      poly[i + 1] || poly[0]
    ];
    if (areIntersecting(side, ray)) intersections++;
  }

  return intersections % 2 !== 0;
}
