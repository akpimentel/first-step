# first-step


### fslreorient2std T2_rata_AnaKaren.nii.gz T2_rata_AnaKaren_reo.nii.gz 
### fslorient -deleteorient T2_rata_AnaKaren_reo1.nii.gz
### fslswapdim T2_rata_AnaKaren_reo.nii.gz -x z -y T2_rata_AnaKaren_reo_1.nii.gz
### fslorient -setqformcode 1 T2_rata_AnaKaren_reo_1.nii.gz
### fslroi T2_rata_AnaKaren_reo_1.nii.gz crop.nii.gz 85 199 0 19 117 151 0 1
