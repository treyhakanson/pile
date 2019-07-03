// verbose
function chooseBestSum(t, k, ls) {
	debugger;
	var all = [], j = 0;
	var combinations = function(i, cur, all) {
		if (cur.length < k - 1) {
			cur.push(ls[i]);
			return combinations(++i, cur, all);
		} else if (j < ls.length - 1) {
			for (; i < ls.length; i++)
				all.push(cur.concat(ls[i]));
			return combinations(++j, [], all);
		} else return all;
	}
	return combinations(j, [], all);
}

const ls = [50, 55, 57, 58, 60], t = 174, k = 3;
const combos = chooseBestSum(t, k, ls);
console.log(combos);

// condensed