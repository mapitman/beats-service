package main

import (
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/mapitman/internet-time"
)

func main() {
	r := gin.Default()
	r.LoadHTMLGlob("templates/*")
	r.GET("/beats", func(c *gin.Context) {
		beats := internettime.ConvertToBeats(time.Now())
		obj := gin.H{
			"beats": beats,
		}
		if strings.Contains(c.GetHeader("accept"), "application/json") {
			c.Header("Content-Type", "application/json")
			c.JSON(200, obj)
		} else {
			c.Header("Content-Type", "text/html")
			c.HTML(200, "beats.html", obj)
		}
	})

	r.Run()
}
