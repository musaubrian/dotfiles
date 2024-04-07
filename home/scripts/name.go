package main

import (
	"fmt"
	"math/rand"
)

func main() {
	wl := 3
	cs := "BCDFGHJKLMNPQRSTVWXZY"
	vs := "AEIOU"
	var result string

	for i := 0; i < wl; i++ {
		result += string(cs[rand.Intn(len(cs))])
		result += string(vs[rand.Intn(len(vs))])
	}
	fmt.Println(result)
}
