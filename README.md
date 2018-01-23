# Análisis de las IRM Estructurales de Rata  
En este repositoria vamos a guardar los pasos así como los scripts necesarios para realizar el preproesamiento básico y el análisis estructural de las imágenes estructurales pesadas a T2 de rata para detectar lesiones.  
Es necesario realizar un preprocesamiento semi-automatizado (depende si podemos hacer el crop automatizado o no), posteriormente una segmentacion manual de la lesion sobre la imágen de alta resolución.  
Finalmente se realizara un corregisto al atlas [Waxholm Space Atlas of the Sprague Dawley (WHS-SD)](https://www.nitrc.org/projects/whs-sd-atlas).  
NOTA: IDealmente se deberian tener dos imagenes por sujeto-rata, una pre y una post lesion para un mejor corregistro entre ellas, para estimar las deformaciones estructurales producidas por la lesion y para mejorar el corregistro no lineal al atlas WHS-SD.  

> Referencia del atlas: Papp, E. A., Leergaard, T. B., Calabrese, E., Johnson, G. A., & Bjaalie, J. G. (2014). Waxholm Space atlas of the Sprague Dawley rat brain. NeuroImage, 97, 374-386, [DOI: j.neuroimage.2014.04.001](https://doi.org/10.1016/j.neuroimage.2014.04.001).  

# Preprocesamiento Estructural  
## 1. Reorientacion de las Imagenes
``` bash
### fslreorient2std T2_rata_AnaKaren.nii.gz T2_rata_AnaKaren_reo.nii.gz 
### fslorient -deleteorient T2_rata_AnaKaren_reo1.nii.gz
### fslswapdim T2_rata_AnaKaren_reo.nii.gz -x z -y T2_rata_AnaKaren_reo_1.nii.gz
### fslorient -setqformcode 1 T2_rata_AnaKaren_reo_1.nii.gz
```
  
## 2. Recorte de los volumenes  
``` bash
fslroi T2_rata_AnaKaren_reo_1.nii.gz crop.nii.gz 85 199 0 19 117 151 0 1
```  
  
## 3. Denoise  
Aquí hay dos métodos que se pueden utilizar uno basado en *non-local means* y *bias field correction* ya se encuentra implementado y libre, hay que checar este script [`T1_denoiseN4`](https://github.com/rcruces/MRI_analytic_tools/blob/master/Freesurfer_preprocessing/T1_denoiseN4)  

