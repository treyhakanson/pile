function flatten(arr) {
  return arr.reduce((x, y) => {
    if (Array.isArray(y)) {
      Array.prototype.push.apply(x, flatten(y));
    } else {
      x.push(y);
    }
    return x;
  }, []);
}

function lookAndSay(n) {
  // O(n + 2m) = O(n + m)
  let seq = "1";
  let re = /(\d)\1*/g;

  for (let i = 0; i < n; i++) {
    // O(n)
    let groups = seq.match(re); // O(m)
    seq = groups.reduce((x, y) => {
      // worst case, O(m)
      return `${x}${y.length}${y[0]}`;
    }, "");
  }

  return seq;
}
