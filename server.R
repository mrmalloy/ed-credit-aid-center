
library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

tot_exp <- eventReactive(input$enter, {
  
  input$box1 + input$otherExp
  
})
    
option1_exp <- eventReactive(input$enter, {
  
  if(tot_exp() - input$box5 > 4000) {
    
    4000
    
  } else if (tot_exp() < input$box5) {
    
    0
  
  } else {
    
   tot_exp() - input$box5
    
  }

                            })


option1_taxschol <- eventReactive(input$enter, {
  
  if (tot_exp() > input$box5) {
    
    "N/A"  ## If expenses > scholarship, not applicable
    
  } else {
    
    input$box5 - tot_exp()  ## otherwise total difference is taxable
    
  }
  
                                })

option1_nontaxschol <- eventReactive(input$enter, {
  
  if(input$box5 == 0) {
    
    0
    
  } else if (tot_exp() > input$box5) {
    
    input$box5  ## if expenses are greater than schol, all nontaxable
    
  } else if (input$box5 > tot_exp()) {
    
    tot_exp()   ## Portion of schol. offset by tuition = nontaxable
    
  }
  
                                    })

option2_exp <- eventReactive(input$enter, {
  
  if(tot_exp() < 4000) {
    
    tot_exp()
    
    } else {
    
   4000
    
  }
  
                              })

option2_taxschol <- eventReactive(input$enter, {

  if(tot_exp() < 4000) {

    input$box5
    
  } else {
    
    input$box5 - tot_exp() + 4000
    
  }
                                              })


option2_nontaxschol <- eventReactive(input$enter, {
  
  if(option2_taxschol() == input$box5) {
    
    0
    
  } else {
    
    input$box5 - option2_taxschol()
    
          }
  
                                                     })


observeEvent(input$enter, {
  
  output$option1 <- renderUI({
    
    if(input$studentType == "dependent") {
      
      HTML(
        sprintf("<b><p>Taxpayer's Return</b></p>
              <p><b>Eligible Expenses:</b> $%s</p>
              <p><b>Taxable Scholarship:</b> N/A</p>
              <p><b>Nontaxable Scholarship:</b> $%s</p>
              <p><b>Dependent's Return</b></p>
              <p><b>Eligible Expenses:</b> N/A</p>
              <p><b>Taxable Scholarship:</b> $%s</p>
              <p><b>Nontaxable Scholarship:</b> N/A</p>",
                
                as.character(option1_exp()),
                as.character(option1_nontaxschol()),
                as.character(option1_taxschol())
                
                )
            )
      
      
    } else {
      
      HTML(
        sprintf("<p><b>Eligible Expenses:</b> $%s</p>
              <p><b>Taxable Scholarship:</b> $%s</p>
              <p><b>Nontaxable Scholarship:</b> $%s</p>",
                as.character(option1_exp()),
                as.character(option1_taxschol()),
                as.character(option1_nontaxschol())
                
        )
      )
      
      
    }
 
  })
    
   output$option2 <- renderUI({
     
    if (option1_exp() >= 4000)  {
       
       HTML(
         sprintf(
           "<span style=\"color:red\">Expenses already maximized - use option 1</span>"
                )
            )
       
     }  else if (input$box5 == 0) {
       
       HTML(
         sprintf(
           "<span style=\"color:red\">No scholarship to reclassify - use option 1</span>"
                )
            )
       
     } else if(input$studentType == "dependent") {
       
       
       HTML(
         sprintf("<b><p>Taxpayer's Return</b></p>
              <p><b>Eligible Expenses:</b> $%s</p>
              <p><b>Taxable Scholarship:</b> N/A</p>
              <p><b>Nontaxable Scholarship:</b> $%s</p>
              <p><b>Dependent's Return</b></p>
              <p><b>Eligible Expenses:</b> N/A</p>
              <p><b>Taxable Scholarship:</b> $%s</p>
              <p><b>Nontaxable Scholarship:</b> N/A</p>",
                 as.character(option2_exp()),
                 as.character(option2_nontaxschol()),
                 as.character(option2_taxschol())
                 
         )
       )
       
     } else {
       
       HTML(
         sprintf("<p><b>Eligible Expenses:</b> $%s</p>
                  <p><b>Taxable Scholarship:</b> $%s</p>
                  <p><b>Nontaxable Scholarship:</b> $%s</p>",
                  as.character(option2_exp()),
                  as.character(option2_taxschol()),
                  as.character(option2_nontaxschol())
                 
                 )
            )
       
           }
     
       })
   
   output$option3 <- renderUI({
     
     if (option1_exp() >= 4000)  {
       
       HTML(
         sprintf(
           "<span style=\"color:red\">Expenses already maximized - use option 1</span>"
                 )
             )
       
     }  else if (input$box5 == 0) {
       
       HTML(
         sprintf(
           "<span style=\"color:red\">No scholarship to reclassify - use option 1</span>"
                 )
           )
       
     # } else if(input$otherCredits == 'No') {
     #   
     #   HTML(
     #     sprintf(
     #       "<span style=\"color:red\">The taxpayer's credits will not be impacted by maximizing expenses. Do not complete Part 3.</span>"
     #            )
     #      )
     #   
     } else { 
       
       HTML(
         sprintf("Maximizing qualified expenses maybe not be the most advantageous treatment for a taxpayer who receives EIC or ACTC. Test other values in TaxSlayer. Enter an eligible expense amount between the values in Option 1 and Option 2 in TaxSlayer. Decrease taxable scholarship by the difference between your new expenses value and Option 2's, and increase nontaxable scholarship by the same increment."
                )
            )
       
     }
     
                        })
   
   
   
   output$opt1_result <- renderUI({
     
     if(is.na(opt1_sum())) {
       
     } else if (opt1_sum() >= 0) {
       
       HTML(sprintf("If option 1 values are used, the taxpayer will receive a net refund of $%s.",
                    opt1_sum())
       )
       
     } else {
       
       HTML(sprintf("If option 1 values are used, the taxpayer will owe $%s.",
                    abs(opt1_sum()))
       )
       
     }  # end if/then
     
   })  # end renderUI
   
   output$opt2_result <- renderUI({
     
     if (tot_exp() - input$box5 > 4000) {
       
       
     } else if(is.na(opt2_sum())) {
       
       
     } else if (opt2_sum() >= 0) {
       
       HTML(sprintf("If option 2 values are used, the taxpayer will receive a net refund of $%s.",
                    opt2_sum())
       )
       
     } else {
       
       HTML(sprintf("If option 2 values are used, the taxpayer will owe $%s.",
                    abs(opt2_sum()))
       )
       
     }  # end if/then
     
   })  # end renderUI
   
   
   output$opt3_result <- renderUI({
     
     if (tot_exp() - input$box5 > 4000) {
       
       
  #   } else if(input$otherCredits=="No") {
       
       
     } else if(is.na(opt3_sum())) {
     
         
     } else if(opt3_sum() >= 0) {
       
       HTML(sprintf("If option 3 values are used, the taxpayer will receive a net refund of $%s.",
                    opt3_sum())
       )
       
     } else if (opt3_sum() < 0){
       
       HTML(sprintf("If option 3 values are used, the taxpayer will owe $%s.",
                    abs(opt3_sum()))
       )
       
     } else {
       
     }  # end if/then
     
   })  # end renderUI
   
   
   output$opt1_best <- renderUI({
     
     if (is.na(opt1_sum())|is.na(opt2_sum())) {
       
       
       
     } else if (!is.na(opt1_sum()) &
                 !is.na(opt2_sum()) &
                 !is.na(opt3_sum()) &
                 opt1_sum() > opt2_sum() &
                 opt1_sum() > opt3_sum()) {
       
       "Option 1 is most advantageous for the taxpayer. Use these values on the return."
       
     } else if (!is.na(opt1_sum()) &
                !is.na(opt2_sum()) &
                input$otherCredits== "No" &
                opt1_sum() > opt2_sum()) {
       
       "Option 1 is most advantageous for the taxpayer. Use these values on the return."
       
     } else {
       
       
       
     }
     
   })
   
   output$opt2_best <- renderUI({
     
     if (is.na(opt1_sum())|is.na(opt2_sum())) {
       
       
       
     }  else if (tot_exp() - input$box5 > 4000) {
       
       
       
     }  else if(!is.na(opt1_sum()) &
                !is.na(opt2_sum()) &
                !is.na(opt3_sum()) &
                opt2_sum() >= opt1_sum() &
                opt2_sum() >= opt3_sum()) {
         
         "Option 2 is most advantageous for the taxpayer. Use these values on the return."
         
       } else if (!is.na(opt1_sum()) &
                  !is.na(opt2_sum()) &
                   input$otherCredits== "No" &
                   opt2_sum() > opt1_sum()) {
         
         "Option 2 is most advantageous for the taxpayer. Use these values on the return."
         
       } else {
         
        
         
       }
     
   })
   
   
   output$opt3_best <- renderUI({
     
     # if (input$otherCredits=="No") {
     #   
     #   
     #   
     # }  else 
       
    if (tot_exp() - input$box5 > 4000) {
       
       
       
     }  else if(!is.na(opt1_sum()) &
                !is.na(opt2_sum()) &
                !is.na(opt3_sum()) &
                opt3_sum() >= opt1_sum() &
                opt3_sum() >= opt2_sum()) {
       
       "Option 3 is most advantageous for the taxpayer. Use these values on the return."
       
     } else {
       
       
       
     }
     
   })
   
})  # end observe


opt1_sum <- reactive({
  
  input$opt1_fed + input$opt1_m1 + input$opt1_dep_fed + input$opt1_dep_m1
  
})


opt2_sum <- reactive({
  
  input$opt2_fed + input$opt2_m1 + input$opt2_dep_fed + input$opt2_dep_m1
  
})


opt3_sum <- reactive({
  
  # if(input$otherCredits == 'No') {
  #   
  #   NA
  #   
  # } else {
    
    input$opt3_fed + input$opt3_m1 + input$opt3_dep_fed + input$opt3_dep_m1 
    
  # }
  
})




} ## end server 
