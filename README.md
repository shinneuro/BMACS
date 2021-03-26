# BMACS

Bayesian meta-analysis of the cortical surface (BMACS) is a novel model-based meta-analysis method that performs meta-analysis on the cortical surface. The core model is based on the log-Gaussian Cox processes (LGCP), and is performed through the integrated nested Laplace approximation (INLA) for parameter estimation. This repository contains the code to perform BMACS for human reasoning.

## Usage

**TL;DR** To replicate the analysis, execute `*.Rmd` files in `scripts` folder in numerical order.

Folder description:

* `data`: Current study uses BMACS to study human reasoning (inductive/deductive). To perform the meta-analysis, coordinates from 76 studies were collected and released in `data/data_coords_*.csv`.
* `scripts`: `*.Rmd` files contain codes used in the analysis. See `*.html` files for rendered version.
* `output`: various result files are located here. To see the resulting reasoning maps estimated by BMACS, check `*.dlabel.nii` files where the brain is represented on the fs_LR 32k meshes.
* `R`: functions used in the current analysis.
* `external`: external software/data used in the current analysis.

## External Dependencies

Some essential software that were used in BMACS are listed below.

### R packages

`INLA`: To run BMACS using R-INLA

`inlabru`: To simulate lgcp 

`gifti`, `freesurferformats`, `ciftiTools`: To read/write brain data files

`here`, `glue`, `tidyverse`: data-analysis tools


### Coordinate conversion (MNI to fsaverage)

The [RegistrationFusion](https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/registration/Wu2017_RegistrationFusion/bin/standalone_scripts_for_MNI_fsaverage_coordinates_conversion) from [CBIG](https://github.com/ThomasYeoLab/CBIG) was used to project coordinates from MNI space to fsaverage space.

The package is modified and redistributed in the current repository, which follows [MIT license](https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md). 

`MATLAB` and `Freesurfer` need to be installed.

### Connectome workbench and surface meshes

The `wb_command` and surface meshes are needed to produce final output on the `fs_LR` surface, following the recommendation of [HCP wiki](https://wiki.humanconnectome.org/display/PublicData/HCP+Users+FAQ#HCPUsersFAQ-9.HowdoImapdatabetweenFreeSurferandHCP?).

Connectome workbench can be downloaded through [here](https://www.humanconnectome.org/software/get-connectome-workbench).

The data can be acquired through running `scripts/003_Posterior-Analysis.Rmd` or you can download from [here](http://brainvis.wustl.edu/workbench/standard_mesh_atlases_8may2017.zip).

## License

see [License](https://github.com/mshin-brain/BMACS/blob/main/LICENSE).