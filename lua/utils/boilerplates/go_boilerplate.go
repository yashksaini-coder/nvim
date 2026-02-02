package main

import (
	"bufio"
	"os"
	"strconv"
	"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	t := readInt(reader)
	for t > 0 {
		t--
	}
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func readInt(r *bufio.Reader) int {
	line, err := r.ReadString('\n')
	check(err)
	line = strings.TrimSpace(line)
	num, _ := strconv.Atoi(line)
	return num
}

func readLineStrings(r *bufio.Reader) []string {
	line, err := r.ReadString('\n')
	check(err)
	line = strings.TrimSpace(line)
	return strings.Split(line, " ")
}

func readLineInts(r *bufio.Reader) []int {
	strArr := readLineStrings(r)
	res := make([]int, len(strArr))
	for i, s := range strArr {
		res[i], _ = strconv.Atoi(s)
	}
	return res
}
