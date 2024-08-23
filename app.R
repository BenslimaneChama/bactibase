library(shiny)
library(slickR)
library(shinyWidgets)
library(bslib)

# Sample Data
bacteria_info <- list(
  "E. coli" = list(
    images = c("ecoli1.jpg", "ecoli2.jpg", "ecoli3.jpg"),
    taxonomy = list(
      "Domain" = "Bacteria",
      "Phylum" = "Proteobacteria",
      "Class" = "Gammaproteobacteria",
      "Order" = "Enterobacterales",
      "Family" = "Enterobacteriaceae",
      "Genus" = "Escherichia",
      "Species" = "Escherichia coli"
    ),
    general_info = list(
      text = "The genome of Escherichia coli (E. coli) is highly diverse, typically spanning around 5 million base pairs (bp) with a GC content of approximately 50%, and encoding 4,500 to 5,000 protein-coding genes, along with various RNA genes and mobile genetic elements like prophages and plasmids. This genetic diversity, particularly among different strains, underpins E. coli's ability to adapt to various environments and hosts. For instance, the multidrug-resistant E. coli strain EC958 has a genome of 5,109,767 bp with 4,982 protein-coding genes, including virulence-associated genes essential for pathogenicity, such as those involved in adhesion, iron acquisition, and toxin production. This genomic variability across strains, especially in genes related to virulence, antibiotic resistance, and environmental adaptation, highlights E. coli's capacity to thrive in diverse contexts, playing roles in both health and disease [1].",
      references = c(
        "[1] Source : Hayashi, T., Makino, K., Ohnishi, M., Kurokawa, K., Ishii, K., Yokoyama, K., ... & Yamada, S. (2001). Complete genome sequence of enterohemorrhagic Escherichia coli O157 and genomic comparison with a laboratory strain K-12. DNA Research, 8(1), 11-22."
      ),
      figure = "ecoli_genome.png"
    ),
    pathogenicity = list(
      text = "Escherichia coli is a versatile bacterium that can act as both a commensal and a pathogen, with pathogenic strains responsible for various human diseases such as diarrhea, urinary tract infections (UTIs), sepsis, and meningitis. The pathogenicity of E. coli largely depends on the acquisition of virulence genes located on plasmids, pathogenicity islands, or other mobile genetic elements. Pathogenic E. coli can be classified into several pathotypes, including Enterotoxigenic E. coli (ETEC), which produces toxins causing watery diarrhea; Enteropathogenic E. coli (EPEC), which adheres to the intestinal epithelium causing attaching and effacing lesions; Enterohemorrhagic E. coli (EHEC), which produces Shiga toxins leading to bloody diarrhea and potentially hemolytic uremic syndrome (HUS); and Uropathogenic E. coli (UPEC), which causes UTIs through the expression of adhesins, toxins, and other virulence factors. These virulence mechanisms typically involve adhesins for attachment to host tissues, toxins that disrupt host cell function, and secretion systems like the Type III secretion system, which injects bacterial effector proteins into host cells to promote bacterial survival and replication [1].",
      references = c(
        "[1] Source 1: Schmidt, H., & Hensel, M. (2004). Pathogenicity islands in bacterial pathogenesis. Clinical Microbiology Reviews, 17(1), 14-56."
      ),
      figure = "ecoli_pathogenicity.png"
    ),
    resistance = list(
      text = "Several antibiotics are effective against Escherichia coli, but their efficacy can vary depending on the strain and its resistance profile. Commonly used antibiotics include fluoroquinolones, which disrupt DNA replication; beta-lactams, which target cell wall synthesis; aminoglycosides, which inhibit protein synthesis; and trimethoprim-sulfamethoxazole (TMP-SMX), which interferes with folate synthesis. However, the effectiveness of these antibiotics is increasingly challenged by resistance mechanisms. For instance, mutations in target genes like gyrA and parC can confer resistance to fluoroquinolones, while beta-lactamases, including extended-spectrum beta-lactamases (ESBLs) and carbapenemases, can degrade beta-lactams, rendering them ineffective. Aminoglycoside resistance often arises from the acquisition of modifying enzymes that prevent the drug from binding to bacterial ribosomes. Additionally, mutations in folate pathway genes reduce the effectiveness of TMP-SMX. The emergence of multi-drug resistant E. coli strains, particularly those producing ESBLs or carbapenemases, poses a significant challenge in clinical settings, limiting treatment options and increasing the risk of severe and persistent infections [1;2].",
      references = c(
        "[1] Source 1: Hooper, D. C., & Jacoby, G. A. (2015). Mechanisms of drug resistance: quinolone resistance. Annals of the New York Academy of Sciences, 1354(1), 12-31.",
        "[2] Source 2: Livermore, D. M. (1995). Beta-lactamases in laboratory and clinical resistance. Clinical Microbiology Reviews, 8(4), 557-584."
      ),
      figure = "ecoli_resistance.png"
    )
  ),
  "Salmonella enterica" = list(
    images = c("salmonella1.jpg", "salmonella2.jpg", "salmonella3.jpg"),
    taxonomy = list(
      "Domain" = "Bacteria",
      "Phylum" = "Proteobacteria",
      "Class" = "Gammaproteobacteria",
      "Order" = "Enterobacterales",
      "Family" = "Enterobacteriaceae",
      "Genus" = "Salmonella",
      "Species" = "Salmonella enterica"
    ),
    general_info = list(
      text = "Salmonella enterica has a relatively large and complex genome, typically ranging from 4.5 to 5.0 megabases (Mb) in size, depending on the strain. The genome is composed of a single circular chromosome and sometimes includes plasmids that carry additional virulence and antibiotic resistance genes. The GC content of S. enterica averages around 52%, which is typical for many enteric bacteria. The genome encodes approximately 4,000 to 5,500 genes, including those responsible for basic cellular functions, virulence, and adaptation to various environments. The presence of genomic islands, particularly the Salmonella pathogenicity islands (SPIs), highlights the bacterium’s ability to acquire and integrate foreign DNA, contributing to its adaptability and pathogenic potential[1].",
      references = c(
        "[1] Source 1: Complete and Assembled Genome Sequence of Salmonella enterica subsp. enterica Serotype Senftenberg N17-509, a Strain Lacking Salmonella Pathogen Island 1."
      ),
      figure = "salmonella_genome.png"
    ),
    pathogenicity = list(
      text = "Salmonella enterica is a pathogenic bacterium responsible for a wide range of human diseases, including gastroenteritis, bacteremia, enteric fever, and an asymptomatic carrier state, with infections most common in children under five, adults between 20 and 30, and the elderly. These infections typically originate in the intestines, where Salmonella colonizes and multiplies, with the cecum playing a crucial role in the infection process. The bacterium's pathogenicity is driven by its ability to invade host cells and manipulate the host's immune responses, largely through two type III secretion systems (T3SS) encoded by genes on pathogenicity islands SPI-1 and SPI-2. The SPI-1 T3SS is essential for the initial invasion of host epithelial cells, injecting effector proteins that facilitate entry and trigger inflammation, while the SPI-2 T3SS is key to the bacterium's survival and replication within host cells, particularly within the phagosomal compartment. Additional virulence genes, such as hilA (regulator of SPI-1), invA (invasion), and sifA (intracellular survival), further contribute to the bacterium's ability to cause disease[1].",
      references = c(
        "[1] Source 1: Ryan, K. J., & Ray, C. G. (Eds.). (2004). Sherris Medical Microbiology: An Introduction to Infectious Disease. (Fourth Edition. ed.). New York: McGraw-Hill."
      ),
      figure = "salmonella_pathogenicity.png"
    ),
    resistance = list(
      text = "Salmonella enterica can be treated with various antibiotics, including fluoroquinolones like ciprofloxacin, cephalosporins such as ceftriaxone, and macrolides like azithromycin, although their effectiveness varies depending on the strain's resistance profile. Fluoroquinolones work by inhibiting DNA gyrase and topoisomerase IV, enzymes crucial for DNA replication and transcription, leading to DNA fragmentation and bacterial cell death. Cephalosporins disrupt the bacterial cell wall by binding to penicillin-binding proteins (PBPs), essential for peptidoglycan synthesis, resulting in cell lysis. Macrolides target the 50S ribosomal subunit, blocking protein synthesis by preventing the elongation of the polypeptide chain. However, resistance to these antibiotics is a growing concern and often results from specific genetic mutations within S. enterica. For instance, mutations in the gyrA gene can confer resistance to fluoroquinolones, while alterations in PBPs or the production of β-lactamases can diminish the efficacy of cephalosporins. Additionally, mutations in ribosomal genes can interfere with macrolide binding, further complicating treatment efforts[1;2;3].",
      references = c(
        "[1] Source 1: Piddock, L. J. V. (2002). Fluoroquinolone resistance in Salmonella serovars isolated from humans and animals. FEMS Microbiology Reviews, 26(1).",
        "[2] Source 2: Livermore, D. M. (1995). Beta-lactamases in laboratory and clinical resistance. Clinical Microbiology Reviews, 8(4), 557-584.",
        "[3] Source 3: World Health Organization (2017). Guidelines for the Treatment of Typhoid Fever."
      ),
      figure = "salmonella_resistance.png"
    )
  ),
  "Staphylococcus aureus" = list(
    images = c("staphylo1.jpg", "staphylo2.jpg", "staphylo3.jpg"),
    taxonomy = list(
      "Domain" = "Bacteria",
      "Phylum" = "Firmicutes",
      "Class" = "Bacilli",
      "Order" = "Bacillales",
      "Family" = "Staphylococcaceae",
      "Genus" = "Staphylococcus",
      "Species" = "Staphylococcus aureus"
    ),
    general_info = list(
      text = "Staphylococcus aureus has a relatively small genome compared to other bacteria, typically ranging from 2.8 to 2.9 megabases (Mb). The genome is composed of a single circular chromosome and may include plasmids, which often carry antibiotic resistance genes and virulence factors. The GC content of S. aureus is around 32-33%, which is characteristic of the Firmicutes phylum. The S. aureus genome encodes approximately 2,500 to 2,800 genes. These genes are responsible for various cellular functions, including metabolic processes, virulence, and antibiotic resistance. The presence of mobile genetic elements such as plasmids, transposons, and prophages contributes to the genetic diversity and adaptability of S. aureus, allowing it to acquire new traits, such as resistance to antibiotics or increased virulence[1].",
      references = c(
        "[1] Source 1: Kuroda, M., Ohta, T., Uchiyama, I., Baba, T., Yuzawa, H., Kobayashi, I., ... & Hiramatsu, K. (2001). Whole genome sequencing of meticillin-resistant Staphylococcus aureus. The Lancet, 357(9264), 1225-1240."
      ),
      figure = "staphylo_genome.png"
    ),
    pathogenicity = list(
      text = "Staphylococcus aureus is a versatile pathogen responsible for a range of infections, from minor skin infections to severe diseases like sepsis, pneumonia, and endocarditis. Its pathogenicity is due to the production of various virulence factors, including surface proteins that facilitate adhesion to host tissues and immune evasion, such as Protein A, which prevents phagocytosis. S. aureus also produces potent toxins like alpha-toxin, which damages host cell membranes, and Panton-Valentine leukocidin (PVL), which targets white blood cells. Additionally, enzymes such as coagulase help the bacterium establish infections by protecting it from the immune system. The ability of S. aureus to form biofilms, especially on medical devices, further enhances its resistance to antibiotics and immune clearance, making infections particularly challenging to treat.[1;2]",
      references = c(
        "[1] Source 1: Foster, T. J. (2005). Immune evasion by staphylococci. Nature Reviews Microbiology, 3(12), 948-958.",
        "[2] Source 2: Otto, M. (2008). Staphylococcal biofilms. Current Topics in Microbiology and Immunology, 322, 207-228."
      ),
      figure = "staphylo_pathogenicity.png"
    ),
    resistance = list(
      text = "Several antibiotics are effective against Staphylococcus aureus, but resistance, particularly in methicillin-resistant Staphylococcus aureus (MRSA) strains, is a significant challenge. Common antibiotics include beta-lactams like oxacillin, which target cell wall synthesis but are often ineffective against MRSA due to the mecA gene encoding an altered penicillin-binding protein (PBP2a) with lower affinity for beta-lactams. Glycopeptides like vancomycin are used to treat MRSA by inhibiting cell wall synthesis, though resistance has led to the emergence of vancomycin-intermediate and vancomycin-resistant strains (VISA and VRSA). Linezolid, which inhibits protein synthesis by targeting the 50S ribosomal subunit, is another option, though resistance can occur through mutations or the acquisition of the cfr gene. The rise of MRSA and other resistant S. aureus strains poses a significant public health threat, underscoring the need for continuous surveillance and the development of new treatments[1;2].",
      references = c(
        "[1] Source 1: Hiramatsu, K., Hanaki, H., Ino, T., Yabuta, K., Oguri, T., & Tenover, F. C. (1997). Methicillin-resistant Staphylococcus aureus clinical strain with reduced vancomycin susceptibility. Journal of Antimicrobial Chemotherapy, 40(1), 135-136.",
        "[2] Source 2: Livermore, D. M. (2003). Linezolid in vitro: mechanism and antibacterial spectrum. Journal of Antimicrobial Chemotherapy, 51(suppl_2), ii9-ii16."
      ),
      figure = "staphylo_resistance.png"
    )
  ),
  "Mycobacterium tuberculosis" = list(
    images = c("myco1.jpg", "myco2.jpg", "myco3.jpg"),
    taxonomy = list(
      "Domain" = "Bacteria",
      "Phylum" = "Actinobacteria",
      "Class" = "Actinomycetia",
      "Order" = "Mycobacteriales",
      "Family" = "Mycobacteriaceae",
      "Genus" = "Mycobacterium",
      "Species" = "Mycobacterium tuberculosis"
    ),
    general_info = list(
      text = "Mycobacterium tuberculosis has a relatively large and complex genome, with a size of approximately 4.4 megabases (Mb). The genome is composed of a single circular chromosome with a GC content of about 65%, which is higher than in many other pathogenic bacteria. The genome encodes around 4,000 genes, including those responsible for its unique cell wall structure, virulence, and metabolic pathways. M. tuberculosis is characterized by a high degree of genetic conservation, but it also possesses regions of difference (RDs), which are associated with strain-specific variations in virulence. The complex cell wall of M. tuberculosis, rich in mycolic acids, is a critical factor in its ability to resist desiccation, antibiotics, and immune responses. The genome also contains multiple genes involved in lipid metabolism, which are crucial for the bacterium's survival within the host[1].",
      references = c(
        "[1] Cole, S. T., Brosch, R., Parkhill, J., Garnier, T., Churcher, C., Harris, D., ... & Barrell, B. G. (1998). Deciphering the biology of Mycobacterium tuberculosis from the complete genome sequence. Nature, 393(6685), 537-544."
      ),
      figure = "myco_genome.png"
    ),
    pathogenicity = list(
      text = "Mycobacterium tuberculosis, the causative agent of tuberculosis (TB), primarily affects the lungs but can spread to other body parts, with its pathogenicity largely attributed to its ability to survive and replicate within macrophages, the cells meant to destroy it. Key factors include its thick, waxy cell wall rich in mycolic acids, which protects it from desiccation and antibiotics while inhibiting immune responses, and the secretion of proteins like ESAT-6, which help it evade the immune system. Additionally, M. tuberculosis can enter a latent state, allowing it to persist in the host for years without causing symptoms, reactivating when the immune system is compromised, making TB particularly challenging to treat[1][2].",
      references = c(
        "[1] Simeone, R., Bobard, A., Lippmann, J., Bitter, W., Majlessi, L., & Brosch, R. (2012). Phagosomal rupture by Mycobacterium tuberculosis results in toxicity and host cell death. PLoS Pathogens, 8(2), e1002507.",
        "[2] Barry, C. E., Boshoff, H. I., Dartois, V., Dick, T., Ehrt, S., Flynn, J., ... & Young, D. (2009). The spectrum of latent tuberculosis: Rethinking the biology and intervention strategies. Nature Reviews Microbiology, 7(12), 845-855."
      ),
      figure = "myco_pathogenicity.png"
    ),
    resistance = list(
      text = "The treatment of Mycobacterium tuberculosis requires a combination of antibiotics, typically including isoniazid, rifampicin, ethambutol, and pyrazinamide, administered over an extended period to ensure complete eradication. Isoniazid targets mycolic acid synthesis in the bacterial cell wall, while rifampicin inhibits RNA synthesis by binding to RNA polymerase, ethambutol disrupts cell wall biosynthesis, and pyrazinamide, converted to its active form by pyrazinamidase, disrupts bacterial metabolism. However, resistance to these drugs is a growing challenge, with mutations in genes like katG, rpoB, embB, and pncA leading to multidrug-resistant TB (MDR-TB) and extensively drug-resistant TB (XDR-TB). These resistant strains require more complex, prolonged treatment regimens with less effective and more toxic drugs, posing significant global health challenges[1][2].",
      references = c(
        "[1] Vilchèze, C., & Jacobs Jr, W. R. (2007). The mechanism of isoniazid killing: Clarity through the scope of genetics. Annual Review of Microbiology, 61(1), 35-50.",
        "[2] WHO Global Tuberculosis Report 2023."
      ),
      figure = "myco_resistance.png"
    )
  ),
  "Pseudomonas aeruginosa" = list(
    images = c("pseudo1.jpg", "pseudo2.jpg", "pseudo3.jpg"),
    taxonomy = list(
      "Domain" = "Bacteria",
      "Phylum" = "Proteobacteria",
      "Class" = "Gammaproteobacteria",
      "Order" = "Pseudomonadales",
      "Family" = "Pseudomonadaceae",
      "Genus" = "Pseudomonas",
      "Species" = "Pseudomonas aeruginosa"
    ),
    general_info = list(
      text = "Pseudomonas aeruginosa has a relatively large and versatile genome, typically ranging from 6.0 to 7.0 megabases (Mb). The genome consists of a single circular chromosome with a GC content of approximately 66%, which is relatively high. P. aeruginosa encodes around 5,500 to 6,000 genes, reflecting its metabolic versatility and adaptability to diverse environments. This bacterium is known for its ability to thrive in various ecological niches, including soil, water, and human tissues, particularly in immunocompromised individuals. The genome also contains numerous genes associated with antibiotic resistance, virulence factors, and biofilm formation, contributing to its role as a notorious opportunistic pathogen. P. aeruginosa has a wide array of regulatory networks that allow it to respond rapidly to environmental changes and stressors, further enhancing its survival and persistence in hostile environments[1].",
      references = c(
        "[1] Stover, C. K., Pham, X. Q., Erwin, A. L., Mizoguchi, S. D., Warrener, P., Hickey, M. J., & Olson, M. V. (2000). Complete genome sequence of Pseudomonas aeruginosa PAO1, an opportunistic pathogen. Nature, 406(6799), 959-964."
      ),
      figure = "pseudo_genome.png"
    ),
    pathogenicity = list(
      text = "Pseudomonas aeruginosa is a highly adaptable opportunistic pathogen known for causing a wide range of infections, particularly in individuals with compromised immune systems, such as those with cystic fibrosis, burns, or chronic wounds. Its pathogenicity stems from the production of numerous virulence factors, including exotoxins like Exotoxin A, which inhibits protein synthesis in host cells, and enzymes like elastase, which degrades tissues and immune proteins. The bacterium's ability to form biofilms, especially on medical devices and in the lungs of cystic fibrosis patients, further protects it from the immune response and antibiotic treatment, making infections difficult to eradicate. Additionally, the Type III Secretion System (T3SS) injects effector proteins like ExoS, ExoT, ExoU, and ExoY directly into host cells, leading to cytotoxicity and immune evasion. P. aeruginosa can colonize almost any part of the body, causing infections that range from mild skin and ear infections to severe conditions such as pneumonia, septicemia, and chronic lung infections[1].",
      references = c(
        "[1] Lyczak, J. B., Cannon, C. L., & Pier, G. B. (2000). Establishment of Pseudomonas aeruginosa infection: Lessons from a versatile opportunist. Microbes and Infection, 2(9), 1051-1060."
      ),
      figure = "pseudo_pathogenicity.png"
    ),
    resistance = list(
      text = "Pseudomonas aeruginosa is intrinsically resistant to many antibiotics and can acquire additional resistance through various mechanisms, posing a significant clinical challenge. Common antibiotics used against it include beta-lactams like piperacillin-tazobactam, aminoglycosides such as tobramycin, fluoroquinolones like ciprofloxacin, and carbapenems such as meropenem. Resistance mechanisms include the production of beta-lactamases (e.g., AmpC) that hydrolyze beta-lactams, modifications by aminoglycoside-modifying enzymes, mutations in DNA gyrase and topoisomerase IV for fluoroquinolone resistance, and carbapenemase production (e.g., VIM, IMP) that inactivates carbapenems. Additionally, P. aeruginosa can reduce drug uptake by altering porins and increasing efflux pump expression to expel antibiotics. The rise of multidrug-resistant (MDR) and extensively drug-resistant (XDR) strains often necessitates combination therapies and novel antibiotics to effectively treat infections[1].",
      references = c(
        "[1] Breidenstein, E. B. M., de la Fuente-Núñez, C., & Hancock, R. E. W. (2011). Pseudomonas aeruginosa: All roads lead to resistance. Trends in Microbiology, 19(8), 419-426."
      ),
      figure = "pseudo_resistance.png"
    )
  )
)

bacteria_info[["E. coli"]][["taxonomy"]]
bacteria_info[["E. coli"]][["images"]]
bacteria_info[["E. coli"]][["pathogenicity"]]

# Define UI
ui <- navbarPage(
  title = div(img(src = "bactibase_logo.png", height = "300px"), "from Janovapp"),   # Title in the navbar
  theme = bs_theme(
    bg = "#2E2E2E",       # Charcoal background
    fg = "#E0E0E0",       # Light gray text
    primary = "#B22222",  # Crimson red for accents
    secondary = "#1C1C1C" # Deep charcoal for headers
  ),
  
  # Include the custom CSS file
  tags$head(
    includeCSS("www/theme.css")
  ),
  
  # Home tab with bacteria information
  tabPanel(
    "Pathogenic Bacterias and Antibioresistance",
    sidebarLayout(
      sidebarPanel(
        pickerInput("bacteria", "Select Bacteria:",
                    choices = names(bacteria_info),
                    selected = names(bacteria_info)[1]),
        radioButtons("info_type", "Select Information Type:",
                     choices = list("General Info about Genome" = "general_info",
                                    "Pathogenicity Mechanism" = "pathogenicity",
                                    "Antibiotic Resistance" = "resistance"),
                     selected = "general_info")
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel("Images", slickROutput("image_carousel")),
          tabPanel("Family Tree", uiOutput("taxonomy_info")),
          tabPanel("Information", 
                   textOutput("info_text"),
                   imageOutput("info_figure"),
                   uiOutput("info_references"))
        )
      )
    )
  ),
  
  # About Me tab
  tabPanel(
    "About Me",
    fluidRow(
      column(10,  # not full width of the page
             tags$h3("BENSLIMANE Chama"),
             tags$p("Passionate about microbiology with a bachelor's degree in the field, I am eager to delve deeper into specialized studies to further enhance my expertise. My academic journey so far has fueled my curiosity and commitment to understanding the microscopic world, and I am dedicated to advancing my knowledge and contributing to the scientific community."),
             tags$p(
               tags$span(icon("phone", lib = "font-awesome"), style = "color: white;"),
               " +21260441600"
             ),
             tags$p(
               tags$a(href = "https://www.linkedin.com/in/chama-benslimane-887b83272/", 
                      icon("linkedin", lib = "font-awesome"), 
                      " LinkedIn Profile", target = "_blank", 
                      style = "color: white; text-decoration: none;")
             )
      )
    )
  ),
  
  # Add some custom CSS to control image sizes in the carousel
  tags$style(HTML("
    .slick-slide img {
      width: 100% !important;
      height: auto !important;
      object-fit: cover;
    }
    .slick-slide {
      margin: 0px !important;
      padding: 0px !important;
    }
    .tab-content {
      padding: 0px !important;
      margin: 0px !important;
    }
    .container-fluid {
      padding: 0px !important;
      margin: 0px !important;
    }
  "))
)

# Define server logic
server <- function(input, output) {
  # Reactive expression to get selected bacteria's data
  selected_bacteria <- reactive({
    bacteria_info[[input$bacteria]]
  })
  
  # Render image carousel
  output$image_carousel <- renderSlickR({
    images <- selected_bacteria()$images
    slickR(images)
  })
  
  # Render taxonomy information
  output$taxonomy_info <- renderUI({
    taxonomy <- selected_bacteria()$taxonomy
    HTML(paste0(
      "<p><b><i>Domain:</i></b> ", taxonomy[["Domain"]], "</p>",
      "<p><b><i>Phylum:</i></b> ", taxonomy[["Phylum"]], "</p>",
      "<p><b><i>Class:</i></b> ", taxonomy[["Class"]], "</p>",
      "<p><b><i>Order:</i></b> ", taxonomy[["Order"]], "</p>",
      "<p><b><i>Family:</i></b> ", taxonomy[["Family"]], "</p>",
      "<p><b><i>Genus:</i></b> ", taxonomy[["Genus"]], "</p>",
      "<p><b><i>Species:</i></b> ", taxonomy[["Species"]], "</p>"
    ))
  })
  
  # Render selected information
  output$info_text <- renderText({
    selected_bacteria()[[input$info_type]]$text
  })
  
  output$info_figure <- renderImage({
    list(src = file.path("www", selected_bacteria()[[input$info_type]]$figure),
         alt = "Information Figure",
         width = 600, height = 400)
  }, deleteFile = FALSE)
  
  #References
  output$info_references <- renderUI({
    references <- selected_bacteria()[[input$info_type]]$references
    if (!is.null(references)) {
      HTML(paste(references, collapse = "<br>"))
    } else {
      NULL
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)