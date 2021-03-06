library(shiny)

library(ggplot2)
library(gdata)

infile1 <- "~/Documents/r_coursera/RClass/BreastCancerPatientInfo2.txt"
pts <- read.table(infile1,header=T,sep="\t")
infile2 <- "~/Documents/r_coursera/RClass/PatientGeneExpression.txt"
ptm <- read.table(infile2,header=T,sep="\t")
final <- merge(pts,ptm,by="ID")



age11 <- final[final$age<40,c("Sub1","age")]
hit11 <- qplot(Sub1,data=age11,geom = "histogram",binwidth = 0.5, xlab = "Sub1", ylab="frequency", main="Sub1 under age 40")
age12 <- final[final$age<40,c("Oxr1","age")]
hit12 <- qplot(Oxr1,data=age12,geom = "histogram",binwidth = 0.5, xlab = "Oxr1", ylab="frequency", main="Oxr1 under age 40")
age13 <- final[final$age<40,c("Sod1","age")]
hit13 <- qplot(Sod1,data=age13,geom = "histogram",binwidth = 0.5, xlab = "Sod1", ylab="frequency", main="Sod1 under age 40")

age21 <- final[final$age>=40,c("Sub1","age")]
hit21 <- qplot(Sub1,data=age21,geom = "histogram",binwidth = 0.5, xlab = "Sub1", ylab="frequency", main="Sub1 over age 40")
age22 <- final[final$age>=40,c("Oxr1","age")]
hit22 <- qplot(Oxr1,data=age22,geom = "histogram",binwidth = 0.5, xlab = "Oxr1", ylab="frequency", main="Oxr1 over age 40")
age23 <- final[final$age>=40,c("Sod1","age")]
hit23 <- qplot(Sod1,data=age23,geom = "histogram",binwidth = 0.5, xlab = "Sod1", ylab="frequency", main="Sod1 over age 40")


library(gridExtra)



ui <- fluidPage(
  actionButton(inputId = "small", label = "age under 40"),
  actionButton(inputId = "large", label = "age bigger than 40"),
  plotOutput("hist")  
)

server <- function(input,output){
    a = hit11
    b = hit12
    c = hit13
    
    rv <- reactiveValues(a = hit11,b=hit12,c=hit13)
    observeEvent(input$small, { rv$a <- hit11 ;rv$b <- hit12; rv$c <- hit13 })
    observeEvent(input$large, { rv$a <- hit21 ;rv$b <- hit22; rv$c <- hit23 })
    
    output$hist <- renderPlot({
      grid.arrange(rv$a,rv$b,rv$c,nrow=3)
    })

}

shinyApp(ui=ui,server=server)