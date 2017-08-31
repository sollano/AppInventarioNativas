options(java.parameters = "-Xss2048k")
library(shiny)
library(DT)
#library(plotly)
library(formattable)
library(readxl)
#library(plyr)
library(tidyr)
library(dplyr)
library(lazyeval)
library(ggplot2)
library(ggdendro)
library(ggthemes)
library(xlsx)
library(rJava)
library(xlsxjars)
#library(rmarkdown)

shinyUI(
  # Intro, taglists e error messages colors ####
  tagList(tags$style(HTML(".irs-single, .irs-bar-edge, .irs-bar{background: #00a90a}")), # this is actually .css; this changes the color for the sliders
          
          # Cor de todas as mensagens da funcao need
          tags$head(
            tags$style(HTML("
                            .shiny-output-error-validation {
                            color: #00a90a;
                            }
                            "))
            ),
          
          # cor das mensagens que eu especificar com "WRONG"
          tags$head(
            tags$style(HTML("
                            .shiny-output-error-WRONG {
                            color: red;
                            }
                            "))
            ),
          
          # cor das mensagens que eu especificar com "AVISO"
          tags$head(
            tags$style(HTML("
                            .shiny-output-error-AVISO {
                            color: orange;
                            }
                            "))
          ),
          
          
          
          
          navbarPage("App Inventário de Nativas",
                     
                     theme = "green_yeti2.css",
                     # theme = "green.css", # seleciona um tema contido na pasta www
                     # theme = shinythemes::shinytheme("paper"), # seleciona um tema utilizando pacote
                     
                     # Painel Intro ####          
                     tabPanel( "Intro" ,
                               fluidRow(
                                 column(5,
                                        includeMarkdown("about.md")
                                 ),
                                 column(6,
                                        img(contentType = "image/jpg",
                                            src="intro_picture.jpg",
                                            width = 770,
                                            #           height = 750)
                                            height = 856)
                                        
                                 )
                               ) # fluid row
                     ), # Painel Intro             
                     
                     
                     # Upload de dados ####
                     tabPanel("Importação",
                              sidebarLayout(
                                
                                sidebarPanel(
                                  
                                  h3("Dados"),
                                  
                                  radioButtons("df_select", 
                                               "Fazer o upload de um arquivo, ou utilizar o dado de exemplo?", 
                                               c("Fazer o upload", "Utilizar o dado de exemplo"), 
                                               selected = "Fazer o upload"),
                                  
                                  uiOutput("upload"), # tipos de arquivos aceitos
                                  hr(),
                                  uiOutput("upload_csv"), # tipos de arquivos aceitos
                                  uiOutput("upload_xlsx") # tipos de arquivos aceitos
                                  
                                  
                                ), # sidebarPanel
                                
                                mainPanel(
                                  DT::dataTableOutput("rawdata")
                                ) # mainPanel
                              ) # sidebarLayout
                     ),
                     
                     # Mapeamento ####
                     tabPanel("Mapeamento de variáveis",
                     fluidPage(
                       
                       #h1("Shiny", span("Widgets Gallery", style = "font-weight: 300"), 
                       h1("Definição dos nomes das variáveis", 
                          style = "text-align: center;"),
                       br(),
                       
                      #  h4("Nesta aba serão indicados os nomes das colunas que serão utilizadas nas análises em todo o app"),
                       fluidRow(
                         
                         column(4,
                                wellPanel(
                                  h3("Espécie"),
                                  p("Selecione o nome da variável referente à Espécie:"#, 
                                    #style = "font-family: 'Source Sans Pro';"
                                    ),
                                  uiOutput("selec_especies")
                                )), # Coluna Espécie
                       
                       column(4,
                              wellPanel(
                                h3("Parcela"),
                                p("Selecione o nome da variável referente à Parcela:"#, 
                                  #style = "font-family: 'Source Sans Pro';"
                                ),
                                uiOutput("selec_parcelas")
                              )),
                       
                       column(4,
                              wellPanel(
                                h3("Diâmetro (DAP)"),
                                p("Selecione o nome da variável referente à DAP:"#, 
                                  #style = "font-family: 'Source Sans Pro';"
                                ),
                                uiOutput("selec_dap")
                              )) # Coluna dap
                       
                       ), # fluidRow 1
                       
                       fluidRow(
                        
                         
                         column(4,
                                wellPanel(
                                  h3("Altura total"),
                                  p("Selecione o nome da variável referente à Altura total:"#, 
                                    #style = "font-family: 'Source Sans Pro';"
                                  ),
                                  uiOutput("selec_ht")
                                )), # Coluna ht
                         
                         column(4,
                                wellPanel(
                                  h3("Volume com casca"),
                                  p("Selecione o nome da variável referente à Volume com casca:"#, 
                                    #style = "font-family: 'Source Sans Pro';"
                                  ),
                                  uiOutput("selec_vcc")
                                )), # Coluna vcc
                         
                         column(4,
                                wellPanel(
                                  h3("Volume sem casca"),
                                  p("Selecione o nome da variável referente à Volume sem casca:"#, 
                                    #style = "font-family: 'Source Sans Pro';"
                                  ),
                                  uiOutput("selec_vsc")
                                )) # Coluna vsc
                         
                         
                         
                       ),# fluidRow 2
                       
                     fluidRow(
                       
                       column(4,
                              wellPanel(
                                h3("Área da parcela"),
                                p("Selecione o nome da variável referente à Área da parcela:"#, 
                                  #style = "font-family: 'Source Sans Pro';"
                                ),
                                uiOutput("selec_area.parcela")
                              )), # Coluna area.parcela
                       
                       
                       column(4,
                              wellPanel(
                                h3("Área total"),
                                p("Selecione o nome da variável referente à Área total"#, 
                                  #style = "font-family: 'Source Sans Pro';"
                                ),
                                uiOutput("selec_area.total")
                              )), # Coluna area.total
                       
                       
                       column(4,
                              wellPanel(
                                h3("Estrato"),
                                p("Selecione o nome da variável referente à Estrato"#, 
                                  #style = "font-family: 'Source Sans Pro';"
                                ),
                                uiOutput("selec_estrato")
                              )) # Coluna area.total
                       
                       
                     ), # fluidRow 3  
                       
                     
                     fluidRow(
                       
                       
                       column(4,
                              wellPanel(
                                h3("Estrutura vertical"),
                                p("Selecione o nome da variável referente à Estrutura vertical"#, 
                                  #style = "font-family: 'Source Sans Pro';"
                                ),
                                uiOutput("selec_est.vertical")
                              )), # Coluna area.total
                       
                       
                       column(4,
                              wellPanel(
                                h3("Estrutura interna"),
                                p("Selecione o nome da variável referente à Estrutura interna"#, 
                                  #style = "font-family: 'Source Sans Pro';"
                                ),
                                uiOutput("selec_est.interna")
                              )) # Coluna area.total
                       
                       
                     ) # fluidRow 4
                       
                     ) # fluidPage 
                     
                     
                     ),# tabPanel Mapeamento
                     
                     # tabPanel Preparação ####
                     tabPanel("Preparação dos dados", 
                              
                              
                              fluidPage(
                                
                                fluidRow(
                                  
                                  h1("Preparação dos dados",style = "text-align: center;"),
                                  br()
                                ),
                                
                                
                                fluidRow(
                                  
                                  sidebarPanel(
                                    
                                    h3("Intervalo de classe"),
                                    numericInput("int.classe", "Insira o intervalo de classe:", 10, 1, 50, 0.5),
                                    
                                    h3("Diâmetro mínimo"),
                                    numericInput("diam.min", "Insira o diâmetro mínimo:", 10, 1, 100, 1),
                                    
                                    uiOutput("selec_rotuloNI"),
                                    
                                    h3("Remover dados"),
                                    
                                    uiOutput("rm_data_var"),
                                    uiOutput("rm_data_level"),
                                    uiOutput("rm_vars"),
                                    uiOutput("selec_area_parcela_num"),
                                    uiOutput("selec_area_total_num"),
                                    uiOutput("ui_estvol1"),
                                    uiOutput("ui_estvol3"),
                                    uiOutput("ui_estvol4"),
                                    uiOutput("checkbox_calc.est.vert"),
                                    uiOutput("consist_warning1")
                                    
                                    
                                    
                                  ),# sidebarPanel
                                  
                                 mainPanel( tabsetPanel(
                                    tabPanel("Dado pos preparação",
                                             shiny::htmlOutput("avisos_prep"),
                                             DT::dataTableOutput("prep_table"),
                                             hr(),
                                             tableOutput("teste")
                                             ),
                                    tabPanel("Dados inconsistentes",
                                             uiOutput("consist_warning2"),
                                             uiOutput("consist_table_help"),
                                             uiOutput("consist_choice"),
                                             DT::dataTableOutput("consist_table")
                                             )

                                  ))# mainPanel
                                  
                                  
                                )
                                
                              )
                              
                              
                              
                              
                     ), # tabPanel filtrar dados
                     # navbarMenu fitossociologica ####
                     navbarMenu("Análise fitossociológica",
                                
                                # Diversidade ####
                                tabPanel("Índices de diversidade",
                                         
                                         fluidPage(
                                           h1("Índices de diversidade", style = "text-align: center;"),
                                           br(),
                                           fluidRow(
                                             column(5,
                                                    radioButtons("rb_div",
                                                                 h3("Calcular diversidade por parcela?"),
                                                                 c("Sim","Nao"),
                                                                 "Nao",
                                                                 TRUE),
                                                    offset = 7
                                           )),
                                           DT::dataTableOutput("div")
                                         )
                                         
                                ), #Diversidade tab
                                
                                # Similaridade ####
                                tabPanel("Índices de similaridade",
                                         
                                         fluidPage(
                                           
                                           h1("Índices de diversidade", style = "text-align: center;"),
                                           br(),
                                           
                                           fluidRow(
                                             
                                             column(width=4,
                                                    h3("Configuração dos gráficos:")
                                             ),
                                             
                                             column(width=5,
                                                    radioButtons("rb_msim_graph", 
                                                                 "Selecione o método de classificação:", 
                                                                 c("Vizinho mais próximo"  = "single", 
                                                                   "Vizinho mais distante" = "complete", 
                                                                   "Distância euclidiana"  = "average"), 
                                                                 selected = "complete", inline = T)  ), 
                                             
                                             
                                             column(width=3,
                                                    sliderInput("slider_msim_graph", 
                                                                label = "Selecione o número de clusters:", 
                                                                min = 1, 
                                                                max = 10, 
                                                                value = 3,
                                                                step = 1) )
                                           ),
                                           
                                           
                                           fluidRow( 
                                             tabsetPanel(id = "mainPanel_Indices",
                                                         tabPanel("Matriz de Similaridadede de Jaccard", DT::dataTableOutput("msim1") ),
                                                         tabPanel("Dendrograma Jaccard", plotOutput("msim1_graph_",height = "600px"), value="id_msim1_graph" ),
                                                         tabPanel("Matriz de Similaridadede de Sorensen", DT::dataTableOutput("msim2") ),
                                                         tabPanel("Dendrograma Sorensen", plotOutput("msim2_graph_",height = "600px"), value="id_msim2_graph" ) 
                                                         
                                             ) )
                                             
                                           )
                                         
                                ), # Similaridade tab
                                
                                
                                # Agregação ####
                                tabPanel("Índices de agregação",
                                         
                                         fluidPage(
                                           h1("Índices de agregação", style = "text-align: center;"),
                                           br(),
                                           DT::dataTableOutput("agreg")
                                         )
                                         
                                ), # Agregação tab
                                
                                # Estrutura ####
                                tabPanel("Análise Estrutural",
                                         
                                         fluidPage(
                                           h1("Análise estrutural", style = "text-align: center;"),
                                           br(),
                                           fluidRow(
                                             column(width=3,
                                                    h3("Configuração do gráfico:")
                                             ),
                                             column(4,
                                                    numericInput("n_IVI_g", h4("Número de espécies no eixo y:"),10,1,90,1) )),
                                           fluidRow( 
                                             tabsetPanel(id = "mainPanel_Estrutural",
                                                         tabPanel("Análise estrutural", DT::dataTableOutput("estr") ),
                                                         tabPanel("Gráfico IVI", plotOutput("estrg",height = "550px" ) ) )
                                             ) #,
                                         #  fluidRow( column(width=4,uiOutput("rb_graphmsim"),offset = 3 ), 
                                        #             column(width=3,uiOutput("slider_graphmsim")) )
                                           
                                         )
                                
                                         
                                ) # Estrutura tab
                                
                                
                     ),# navbarMenu fitossociologica end ####
                     
                     # navbarMenu Quantificacao ####
                     navbarMenu( "Quantificação",
                       # tabPanel DD ####
                       tabPanel("Distribuição diamétrica",
                                
                                fluidPage(
                                  h1("Distribuição diamétrica (DD)", style = "text-align: center;"),
                                  br(),
                                  tabsetPanel(
                                    
                                    tabPanel("Distribuição diamétrica Geral", DT::dataTableOutput("dd_geral_tab") ),
                                    tabPanel("Distribuição diamétrica dos indivíduos por ha por espécie", DT::dataTableOutput("dd_indv_especie_tab") ),
                                    tabPanel("Distribuição diamétrica do volume por ha por espécie", DT::dataTableOutput("dd_vol_especie_tab") ),
                                    tabPanel("Distribuição diamétrica de G por ha por espécie", DT::dataTableOutput("dd_G_especie_tab") ),
                                    tabPanel("Gráfico dos indivíduos por ha por classe diamétrica", plotOutput("dd_graph_indv",height = "550px") ),
                                    tabPanel("Gráfico do volume por ha por classe diamétrica", plotOutput("dd_graph_vol",height = "550px")),
                                    tabPanel("Gráfico de G por ha por classe diamétrica", plotOutput("dd_graph_G",height = "550px")) 
                                  )
                                  
                                )
                                
                                ), # tabPanel DD 
                       
                       # tabPanel BDq ####
                       tabPanel("BDq",
                                
                                fluidPage(
                                  h1("BDq Meyer", style = "text-align: center;"),
                                  br(),
                                  fluidRow(column(width=5,
                                                  sliderInput("i.licourtBDq", 
                                                              label = "Selecione um valor de quociente de Licourt:", 
                                                              min = 0, 
                                                              max = 5, 
                                                              value = 1.3,
                                                              step = .1),
                                                  offset=7
                                  )),
                                  tabsetPanel(
                                    
                                    tabPanel("BDq", DT::dataTableOutput("BDq1") ),
                                    tabPanel("Gráfico", plotOutput( "BDq_graph_" ,height = "550px") ),
                                    tabPanel("Detalhes do ajuste", DT::dataTableOutput("BDq3", "70%") )
                                    
                                  )
                                  
                                  
                                  
                                )
                                
                                ),# tabPanel BDq
                       # tabPanel Estrutura volumétrica ####
                      # tabPanel("Estrutura volumétrica"),
                       
                       # tabPanel inventario florestal ####
                       tabPanel("Inventário florestal",
                                
                                fluidPage(
                                  
                                              h1("Inventário florestal", style = "text-align: center;"),
                                              br(),
                                              
                                              # ####
                                              fluidRow(
                                             column( 3,  sliderInput("erro_inv", 
                                                            label = "Selecione o erro admitido (%):", 
                                                            min = 1, 
                                                            max = 20, 
                                                            value = 10,
                                                            step = 1)),
                                             
                                             column(3,
                                               sliderInput("alpha_inv", 
                                                           label = "Selecione o nível de significância:", 
                                                           min = 0.01, 
                                                           max = 0.10, 
                                                           value = 0.05,
                                                           step = 0.01)
                                             ),
                                             
                                             column(3,
                                                    sliderInput("cd_inv", 
                                                                label = "Selecione o nº de casas decimais:", 
                                                                min = 0, 
                                                                max = 10, 
                                                                value = 4,
                                                                step = 1)
                                                    ),
                                             
                                             column(3,
                                                    radioButtons(
                                                      inputId='pop_inv', # Id
                                                      label='Considerar a população infinita ou finita?', # nome que sera mostrado na UI
                                                      choices=c(Infinita="inf", Finita="fin"), # opcoes e seus nomes
                                                      selected="inf")
                                                    )
                                              ),
                                              
                                              
                                        fluidRow(   
                                          tabsetPanel(
                                          tabPanel("Totalização de Parcelas",DT::dataTableOutput("tot_parc_tab") ) , 
                                          tabPanel("Amostragem Casual Simples",DT::dataTableOutput("acs") ), 
                                          tabPanel("Amostragem Casual Estratificada",DT::dataTableOutput("ace1"),br(),DT::dataTableOutput("ace2") ), 
                                          tabPanel("Amostragem Sistemática",DT::dataTableOutput("as") ) )
                                        )
                                  # ####
                                    
                                  )
                                  
                                  
                                
                                
                                )# TabPanel Inventario
                       
                       
                     ),  # navbarMenu Quantificacao end ####
                     
                     # navbarMenu  Download ####
                     tabPanel("Download",
                                # Painel Download Tabelas ####
                                
                              fluidPage(
                                
                                
                                h1("Download dos resultados", style = "text-align: center;"),
                                br(),
                                
                                
                              tabsetPanel(
                                tabPanel("Download de tabelas", 
                                         sidebarLayout(
                                           
                                           sidebarPanel(
                                             
                                             h3("Download de tabelas"),
                                             
                                             selectInput("dataset", "Escolha uma tabela:", 
                                                         choices = c(
                                                           "Dados inconsistentes",
                                                           "Dado utilizado / preparado",
                                                           "Indice diversidade",
                                                           "Matriz similaridade - Jaccard",
                                                           "Matriz similaridade - Sorensen",
                                                           "Indice de agregacao",
                                                           "Estrutura",
                                                           "Distribuicao diametrica geral",
                                                           "Dist. Diametrica Indv. por especie",
                                                           "Dist. Diametrica Vol. por especie",
                                                           "Dist. Diametrica G por especie",
                                                           "BDq Meyer",
                                                           "BDq Meyer - Coeficientes",
                                                           "Totalizacao de parcelas",
                                                           "Amostragem Casual Simples", 
                                                           "Amostragem Casual Estratificada 1", 
                                                           "Amostragem Casual Estratificada 2",
                                                           "Amostragem Sistematica"
                                                         )),
                                             
                                             selectInput("datasetformat",
                                                         "Escolha o formato da tabela:",
                                                         choices = c("Valor separado por Virgulas (.CSV)" = ".csv",
                                                                     "Planilha do Excel (.xlsx)" = ".xlsx")
                                             ),
                                             
                                             downloadButton('downloadData', 'Download')
                                             
                                           ),
                                           mainPanel(
                                             DT::dataTableOutput('table')      
                                           )
                                         )
                                ), # download tabelas
                                
                                # Painel Download Graficos ####
                                
                                tabPanel("Download de graficos", 
                                         
                                         
                                         
                                         sidebarLayout(
                                           
                                           sidebarPanel(
                                             
                                             tags$style(type="text/css",
                                                        ".recalculating {opacity: 1.0;}"
                                             ),
                                             
                                             h3("Download de graficos"),
                                             
                                             selectInput("graph_d", "Escolha uma grafico:", 
                                                         choices = c(
                                                           "Dendrograma - Jaccard",
                                                           "Dendrograma - Sorensen",
                                                           "Grafico IVI",
                                                           "Indv. por especie por CC",
                                                           "Vol. por especie por CC",
                                                           "G por especie por CC",
                                                           "Distribuicao - BDq Meyer" )),
                                             
                                             selectInput("graphformat",
                                                         "Escolha o formato do gráfico:",
                                                         choices = c("PNG" = ".png",
                                                                     "JPG" = ".jpg",
                                                                     "PDF" = ".pdf") ),
                                             
                                             downloadButton('downloadGraph', 'Download')
                                             
                                           ),
                                           mainPanel(
                                             plotOutput("graph_d_out",height = "550px")
                                           )
                                         )
                                ) # download graficos
                                
                                )       
                     ) # fluidPage
                     ) # final navbarMenu download ####    
                     # final da UI  ####    
                     ) # navbarPage
  )#tagList
) # ShinyUI


