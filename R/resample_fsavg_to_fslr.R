resample_fsavg_to_fslr <- function(data, name_prefix, hemisphere, template_path, wb_command) {
  
  require(glue)
  
  hemisphere <- toupper(hemisphere)
  stopifnot(hemisphere %in% c("L", "R"))
  
  # cifti template files
  current_sphere <- file.path(template_path, glue("fsaverage_std_sphere.{hemisphere}.164k_fsavg_{hemisphere}.surf.gii"))
  new_sphere <- file.path(template_path, glue("fs_LR-deformed_to-fsaverage.{hemisphere}.sphere.32k_fs_LR.surf.gii"))
  current_midthickness <- file.path(template_path, glue("fsaverage.{hemisphere}.midthickness_va_avg.164k_fsavg_{hemisphere}.shape.gii"))
  new_midthickness <- file.path(template_path, glue("fs_LR.{hemisphere}.midthickness_va_avg.32k_fs_LR.shape.gii"))

  # write temp file 
  input <- tempfile(fileext = ".gii")
  dataarray <- list(unlist(data))
  freesurferformats::gifti_writer(input, dataarray, datatype='NIFTI_TYPE_FLOAT32')

  name <- glue('{name_prefix}.{hemisphere}')
  output <- here::here("output", glue('{name}.32k_fs_LR.func.gii'))
  
  # resample
  cmd <- glue('{wb_command} -metric-resample {input} {current_sphere} {new_sphere} ADAP_BARY_AREA {output} -area-metrics {current_midthickness} {new_midthickness}')
  system(cmd)
  
  # set structure
  brain_structure <- ifelse(hemisphere == "L", "CORTEX_LEFT", "CORTEX_RIGHT")
  cmd <- glue('{wb_command} -set-structure {output} {brain_structure}')
  system(cmd)
  
  
  print(glue("resampled file was saved in {output}"))
  
}