package sort

func partition(slc []int) int {
	lo := 0
	hi := len(slc) - 1
	p := slc[hi]

	for i := lo; i < hi; i++ {
		v := slc[i]
		if v < p {
			tmp := slc[lo]
			slc[lo] = v
			slc[i] = tmp
			lo++
		}
	}

	tmp := slc[lo]
	slc[lo] = p
	slc[hi] = tmp
	return lo
}

func QuickSort(slc []int) {
	if (len(slc) > 1) {
		p := partition(slc)
		QuickSort(slc[:p])
		QuickSort(slc[p + 1:])
	}
}
