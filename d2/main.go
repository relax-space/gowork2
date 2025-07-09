package main

import (
	"fmt"

	"github.com/relax-space/gowork2/d1"
	"github.com/relax-space/gowork2/d3"
)

func main() {
	result := d1.Add(1, 2)
	fmt.Printf("Add 结果是%d", result)

	result3 := d3.Multi(1, 2)
	fmt.Printf("Multi 结果是%d", result3)
}
