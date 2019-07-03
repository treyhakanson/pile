function rotateArray1(arr, rp) {
   for (let i = 0; i < rp; i++) {
      arr.push(arr.shift());
   }
}

function rotateArray2(arr, rp) {
   
}

function findRotationPoint(arr) {
   for (let i = 0; i < arr.length; i++) {

   }
}

function equality(x, y) {
   for (let i = 0; i < x.length; i++) {
      if (x[i] !== y[i]) return false
   }
   return true;
}

let x, y;

console.log("Test rotateArray1:");
x = [1, 2, 3, 4, 5, 6, 7];
y = [3, 4, 5, 6, 7, 1, 2];
rotateArray1(x, 2);
console.log("\t", x);
console.log("\t", y);
console.log("\t", equality(x, y), "\n");

console.log("Test rotateArray2:");
x = [1, 2, 3, 4, 5, 6, 7];
y = [3, 4, 5, 6, 7, 1, 2];
rotateArray2(x, 2);
console.log("\t", x);
console.log("\t", y);
console.log("\t", equality(x, y));
