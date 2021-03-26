convert_mni_to_fsavg <- function(mni_coords, surface='sphere', matlabpath, fshome) {
  
  require(here)
  require(glue)
  require(magrittr)
  
  if (fshome == '') {
    stop('FREESURFER needs to be installed to execute the function')
  } else {
    Sys.setenv(FREESURFER_HOME = fshome)
  }
  if (dim(mni_coords)[2] != 3) {
    stop('The coordinates need to be passed as each row (k x 3)')
  }
  
  script_folder <- here('external', 'standalone_scripts_for_MNI_fsaverage_coordinates_conversion')
  
  mni_coords <- mni_coords %>%
    dplyr::mutate(coords = paste(mni_x, mni_y, mni_z)) %>%
    purrr::pluck('coords') %>%
    paste(collapse = '; ')
  
  tmp_csv <- tempfile(fileext = '.csv')
  
  matlab_code <- c(
    glue("addpath(genpath('{script_folder}'));"),
    glue("[vertices, fs_coords, hemisphere] = CBIG_RF_MNICoord2fsaverageVertexHemi([{mni_coords}]', '{surface}');"),
    "T = array2table([vertices; fs_coords; hemisphere]', 'VariableNames',{'vertices','sx','sy', 'sz', 'hemisphere'});",
    glue("writetable(T, '{tmp_csv}');")
  )
  
  tmp_script <- tempfile(fileext = '.m')
  writeLines(matlab_code, con = tmp_script)
  
  #run MATLAB script
  system(glue("{matlabpath} -batch \"run('{tmp_script}')\""))
  fsavg_coords <- readr::read_csv(tmp_csv)
  
}
