
### server
library(shiny)
# 
shinyServer(function(input, output) {
	
powCalc<- function(N,p){
	# range of correlations
	r <- seq(.1,1,.02)
	nr <- length(r)
	pow<-vector("numeric",length=nr)

	for (i in 1:nr){
		result <- pwr.r.test(n = N, r = r[i],
												 sig.level = p, power = NULL,
												 alternative = "two.sided")
		pow[i] <- result$power
	}
	dat<-data.frame(r=r,power=pow)
	return(dat)
}

data<-reactive({	
	Nb<-input$Nb # sample size passed by user
	pv<-as.numeric(input$pval) # P value passed from user input
	dat <- powCalc(Nb,pv)
	})

	output$PowPlot <- renderPlot({
		Nb<-input$Nb
		pv<-input$pval

	library(ggplot2)
		gp<-ggplot(data(), aes(x=r, y=power)) +
	 geom_line(colour="red", size=1.5) + 
	ggtitle(paste("Sample size =",Nb,"\n","p value = ",pv,sep=" "))+
	xlab("Correlation Coefficient (r)") +
	ylab("Power") +
	scale_y_continuous(breaks=seq(0,1,.1)) +
	scale_x_continuous(breaks=seq(0,1,.1)) +
	theme( 
				panel.grid.major=element_blank(),
				panel.background = element_rect(fill = "lightgreen"))

	print(gp)
		
	})
	
output$table <- renderTable({
	Nb<-input$Nb
	pv<-input$pval
	data()
})
})
