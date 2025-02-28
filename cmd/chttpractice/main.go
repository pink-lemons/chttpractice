package main

import "github.com/gin-gonic/gin"

func main() {

	r := gin.Default()

	r.POST("/v1/sheet/update", updateFunc)

	r.Run(":8080")

	return
}
