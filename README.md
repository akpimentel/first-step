# Análisis de las IRM Estructurales de Rata  
En este repositoria vamos a guardar los pasos así como los scripts necesarios para realizar el preprocesamiento básico y el análisis estructural de las imágenes estructurales pesadas a T2 de rata para detectar lesiones.  
1. Es necesario realizar un preprocesamiento semi-automatizado (depende si podemos hacer el crop automatizado o no).
1. posteriormente una segmentacion manual de la lesion sobre la imágen de alta resolución.  
1. Finalmente se realizara un corregisto al atlas [Waxholm Space Atlas of the Sprague Dawley (WHS-SD)](https://www.nitrc.org/projects/whs-sd-atlas).  

NOTA: Idealmente se deberian tener dos imagenes por sujeto-rata, una pre y una post lesion para un mejor corregistro entre ellas, para estimar las deformaciones estructurales producidas por la lesion y para mejorar el corregistro no lineal al atlas WHS-SD.  

> Referencia del atlas: Papp, E. A., Leergaard, T. B., Calabrese, E., Johnson, G. A., & Bjaalie, J. G. (2014). Waxholm Space atlas of the Sprague Dawley rat brain. NeuroImage, 97, 374-386, [DOI: j.neuroimage.2014.04.001](https://doi.org/10.1016/j.neuroimage.2014.04.001).  

# Preprocesamiento Estructural  
## 1. Reorientacion de las Imagenes  
Los siguientes pasos se implementaron en el script `mrat_reorient`
``` bash
# Reorienta al espacio estandar
fslreorient2std T2_rata_AnaKaren.nii.gz T2_rata_AnaKaren_reo.nii.gz 

# Borra las etiquetas
fslorient -deleteorient T2_rata_AnaKaren_reo1.nii.gz

# Invierte la orietacion x,y
fslswapdim T2_rata_AnaKaren_reo.nii.gz -x z -y T2_rata_AnaKaren_reo_1.nii.gz

# Coloca las nuevas etiquetas
fslorient -setqformcode 1 T2_rata_AnaKaren_reo_1.nii.gz
```
  
## 2. Recorte de los volumenes  
Hay que tratar de automatizar esto en `mrat_crop`.
``` bash
# Esto es un ejemplo
fslroi T2_rata_AnaKaren_reo_1.nii.gz crop.nii.gz 85 199 0 19 117 151 0 1
```  
  
## 3. Denoise  
Aquí se pueden utilizar un método basado en *non-local means* y *bias field correction* ya se encuentra implementado y libre, hay que checar este script [`T1_denoiseN4`](https://github.com/rcruces/MRI_analytic_tools/blob/master/Freesurfer_preprocessing/T1_denoiseN4). La documentación junto con otros métodos de *denoising* esta en este [link](https://sites.google.com/site/pierrickcoupe/softwares/denoising-for-medical-imaging).  
  
 # Análisis de las IRM  
 Los siguentes pasos no son necesariamente secuenciales ya qu epueden realizarse a la mismo tiempo. Sin embargo es necesario que ambos pasos estes realizados para realizar cuantificaciones volumétricas de las lesiones y cambios pre/post.

## Segmentacion manual de las lesiones  
Se recomienda utilizar el programa [`mrtrix`](http://www.mrtrix.org/) con su visualizador [`mrview`](http://mrtrix.readthedocs.io/en/latest/reference/commands/mrview.html?highlight=mrview) para realizar ROIS manuales.  
NOTA: La segmentación debe ser realizada por la misma persona para mantener la variabilidad usuario-dependiente.  
  
## Corregistro no lineal  
Aquí hay que llevar las imagenes ya procesadas al atlas. En el caso de que se cuente con volumenes pre y post lesion hay que llevar la imagen de post-lesion a la pre y la pre al espacio del altas.  
Programas recomendados: [Advance Normalization Tools ANTs](https://stnava.github.io/ANTs/), [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FSL).  

# Cuantificación y Estadística  
Esto es lo último, así que hasta que no este todo lo anterios no hay que por que preocuparse por esto aún.


