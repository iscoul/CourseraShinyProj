
# ui
library(shiny)

# Define UI for application that draws a power plot for correlation
#
shinyUI(fluidPage(
	
	# Application title
	titlePanel("Power Analysis"),
	
	# Sidebar with a slider input for the number of power
	sidebarLayout(
		sidebarPanel(
			sliderInput("Nb",	h4("Sample size:"),min = 4,max = 500,value = 10),
			selectInput("pval", h4("Select p value"),
												 c("0.05" = 0.05,
												 	"0.01" = 0.01,
												 	"0.001" = 0.001, 
													"0.0001" = 0.0001),
													selected = 0.05)
		),
		# Show outputs
		mainPanel(
			tabsetPanel(type="tabs",
			tabPanel("Power Plot", plotOutput("PowPlot")),
			tabPanel("Table",tableOutput("table"))
			)
		)
	)
)
)

