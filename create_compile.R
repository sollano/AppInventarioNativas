#devtools::install_github("ficonsulting/RInno")

library(RInno)
create_app(
  app_name       = "AppInventarioNativas",
  app_dir        = "RInno_files",
  app_version    = "2.0.9",
  #app_repo_url   = "https://github.com/sollano/AppInventarioNativas",
  pkgs           = c("shiny", "DT", "formattable", "readxl", "plyr", "tidyr","dplyr", "ggplot2", "lazyeval", "ggdendro","ggthemes","openxlsx"),
  app_icon       = "LAB_logo.ico",
  setup_icon     = "LAB_logo.ico",
  publisher      = "Treelab ufvjm",
  pub_url        = "http://gorgens.wixsite.com/treelab",
  dir_out        = "exe_folder",
  include_R      = TRUE,
  include_Rtools = TRUE,
  info_before    = "info_before.txt",
  info_after     = "info_after.txt"
)
compile_iss()
