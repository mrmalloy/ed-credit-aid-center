library(shiny)
library(bslib)

fluidPage(
  
  ## tags
  tags$head(
    tags$style(type="text/css", 
                ".inline label{ display: table-cell; 
                                text-align: left;
                                vertical-align: baseline;
                                padding-right: 10px;
                                }
                 .inline .form-group { display: table-row;}
               
                "
               )
            ),
  
  fluidRow(column(12,
                  style = "background-color: #9560A7;
                           padding-top: 2%;
                           padding-bottom: 2%;"
                  ,
           img(src = "turquoise_horizontal_notagline_CMYK.jpg",
               height = "55vh",
               width = "300vw",
               style = "display: block; margin-left: auto; margin-right: auto;"
               )
                  ) # end col
          ),  #end fluid row
  
  
  fluidRow(h1("American Opportunity Credit Calculator",
              style = "text-align: center; font-weight: bold;")
           ),
  
  fluidRow(
          column(2),
          column(8,
              includeHTML("sidebar_text.html"),
        
              br(),
              
              h4(strong("Enter Initial Information",
                        style = "padding-left: 120px")),
              
           #   tags$div(id="inline1", class="inline", textInput(inputId = "txtInp", label = HTML("Label Left 1:&nbsp&nbsp"))),
              
              tags$div(style = "padding-left: 120px",
                       id="entry1", 
                       class="inline",
                       numericInput(inputId = "box1",
                                    label = h5(HTML("1098-T Box 1 - Qualified tuition & expenses&nbsp&nbsp")),
                                    value = NA,
                                    min = 0
                                      )
                       ),
           
              br(),
           
              tags$div(style = "padding-left: 120px",
                       id="entry2", 
                       class="inline",
                       numericInput(inputId = "box5",
                                    label = h5(HTML("1098-T Box 5 - Scholarships & grants&nbsp&nbsp")),
                                    value = NA,
                                    min = 0
                                    )
                      ),
           
              br(),
              
              tags$div(style = "padding-left: 120px",
                       id="entry3", 
                       class="inline",
                       numericInput("otherExp",
                                    label = h5(HTML("Other qualified expenses:&nbsp&nbsp")),
                                    value = 0,
                                    min = 0
                                  )
                       ),
           
             br(),
             
             tags$div(style = "padding-left: 120px",
                      id="entry4", 
                      class="inline",
                      radioButtons("studentType",
                                   label = h5(HTML("The student is the:&nbsp&nbsp")),
                                   choiceNames = list("taxpayer", "taxpayer's dependent"),
                                   choiceValues = list("taxpayer", "dependent"),
                                   inline = TRUE
                                  )
                      ),
             
            # tags$div(style = "padding-left: 120px",
            #          id="entry5",
            #          class="inline",
            #          radioButtons("otherCredits",
            #                       label = h5(HTML("Is the taxpayer receiving earned income credit or additional child tax credit?&nbsp&nbsp")),
            #                       choiceNames = list("Yes", "No"),
            #                       choiceValues = list("Yes ", "No"),
            #                       selected = c("No"),
            #                       inline = TRUE
            #                       )
            #          ),
                   ),
          column(2),
          ),# end fluidRow
           
          br(),
          
          fluidRow(column(2),
                   column(8,
                        align = "center",
                        div(id = "form",
                            
                        actionButton("enter",
                               "Generate Taxslayer Entry Values",
                               icon("calculator"),
                               style ="color: #fff; 
                                        background-color: #00B0B8;",
                               class = "btn-lg"),
                            ) # end div 
                          ), # end col
                  column(2)
                ),
                  
                  br(),
                  br(),
    
  fluidRow(
            column(1),
          
            layout_columns(

                        card(card_header(h4(strong("Option 1 – Baseline Values"))),
                             tags$style(HTML("#opt1_fed.form-control{margin-bottom:-10px}")),
                             tags$style(HTML("#opt1_m1.form-control{margin-bottom:-10px}")),
                             h6(htmlOutput("option1")),
                             numericInput("opt1_agi",
                                   label = "Taxpayer - Federal AGI",
                                   value = NA,
                                   min = 0),
                             numericInput("opt1_fed",
                                         label = "Taxpayer - Federal",
                                         value = NA,
                                         min = -30000),
                             numericInput("opt1_m1",
                                           label = "Taxpayer - M1",
                                           value = NA,
                                           min = -30000),
                             numericInput("opt1_dep_agi",
                                         label = "Dependent - Federal AGI",
                                         value = NA,
                                         min = -30000),
                             numericInput("opt1_dep_fed",
                                           label = "Dependent - Federal",
                                           value = NA,
                                           min = -30000),
                             numericInput("opt1_dep_m1",
                                          label = "Dependent - M1",
                                          value = NA,
                                          min = -30000),
                             h6(uiOutput("opt1_result")),
                             h6(uiOutput("opt1_best"),
                                style = "color:green; font-weight:bold")

                            ),  # end card 1

                        card(card_header(h4(strong("Option 2 – Maximum Expenses"))),
                             tags$style(HTML("#opt2_fed.form-control{margin-bottom:-10px}")),
                             tags$style(HTML("#opt2_m1.form-control{margin-bottom:-10px}")),
                             h6(uiOutput("option2")),
                            numericInput("opt2_agi",
                                         label = "Taxpayer - Federal AGI",
                                         value = NA,
                                         min = 0),
                             numericInput("opt2_fed",
                                          label = "Taxpayer - Federal",
                                          value = NA,
                                          min = -30000),
                             numericInput("opt2_m1",
                                          label = "Taxpayer - M1",
                                          value = NA,
                                          min = -30000),
                             # numericInput("opt2_m1pr",
                             #              label = "Taxpayer - M1PR",
                             #              value = NA,
                             #              min = 0),
                             numericInput("opt2_dep_agi",
                                           label = "Dependent - Federal AGI",
                                           value = NA,
                                           min = -30000),
                             numericInput("opt2_dep_fed",
                                          label = "Dependent - Federal",
                                          value = NA,
                                          min = -30000),
                             numericInput("opt2_dep_m1",
                                          label = "Dependent - M1",
                                          value = NA,
                                          min = -30000),
                             h6(uiOutput("opt2_result")),
                             h6(uiOutput("opt2_best"),
                                style = "color:green; font-weight:bold")

                             ), # end card 2

                        card(card_header(h4(strong("Option 3 – Mid-Max Expenses"))),
                             tags$style(HTML("#opt3_fed.form-control{margin-bottom:-10px}")),
                             tags$style(HTML("#opt3_m1.form-control{margin-bottom:-10px}")),
                             h6(uiOutput("option3")),
                         #    h6("Enter the above amounts into TaxSlayer, and record refund amounts below:",
                        #        style = "margin-botton:-10px"),
                             # numericInput("opt3_expense",
                             #               label = tags$strong("Eligible Expenses"),
                             #               value = NA,
                             #               min = 0),
                             # numericInput("opt3_tax_schol",
                             #               label = tags$strong("Taxable Scholarship"),
                             #               value = NA,
                             #               min = 0),
                             # numericInput("opt3_tax_schol",
                             #               label = tags$strong("Nontaxable Scholarship"),
                             #               value = NA,
                             #               min = 0),
                             numericInput("opt3_agi",
                                         label = "Taxpayer - Federal AGI",
                                         value = NA,
                                         min = 0),
                             numericInput("opt3_fed",
                                          label = "Taxpayer - Federal",
                                          value = NA,
                                          min = -30000),
                             numericInput("opt3_m1",
                                          label = "Taxpayer - M1",
                                          value = NA,
                                          min = -30000),
                             # numericInput("opt3_m1pr",
                             #              label = "Taxpayer - M1PR",
                             #              value = NA,
                             #              min = 0),
                             numericInput("opt3_dep_agi",
                                           label = "Dependent - Federal AGI",
                                           value = NA,
                                           min = -30000),
                             numericInput("opt3_dep_fed",
                                          label = "Dependent - Federal",
                                          value = NA,
                                          min = -30000),
                             numericInput("opt3_dep_m1",
                                          label = "Dependent - M1",
                                          value = NA,
                                          min = -30000),
                             h6(uiOutput("opt3_result")),
                             h6(uiOutput("opt3_best"),
                                style = "color:green; font-weight:bold")

                        ) # end card 3

                             )  # end layout_columns

          
    
            )  ## end fluidRow
  
          )    ## end fliudPage
 