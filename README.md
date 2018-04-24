# Análisis de las IRM Estructurales de Rata  
En este repositorio vamos a guardar los pasos así como los scripts necesarios para realizar el preprocesamiento básico y el análisis estructural de las imágenes estructurales pesadas a T2 de rata para detectar lesiones.  
1. [`mrat_preproc`]() Es necesario realizar un preprocesamiento semi-automatizado que incluya, reorientación, máscara del cerebro, homogenización de las intensidades y mejora en de la calidad señal ruido.
1. [`countROI.R`]() Posteriormente una segmentacion manual de la lesion sobre la imágen de alta resolución procesada y cuantificación del volumen.  
1. [`mrat_nii2atlas`]() Finalmente se realizara un corregisto al atlas [Waxholm Space Atlas of the Sprague Dawley (WHS-SD)](https://www.nitrc.org/projects/whs-sd-atlas).  

NOTA: Idealmente se deberían tener dos imagenes por sujeto-rata, una pre y una post lesion para un mejor corregistro entre ellas, para estimar las deformaciones estructurales producidas por la lesion y para mejorar el corregistro no lineal al atlas WHS-SD.  

> **Referencia del atlas:**  
> - Papp, E. A., Leergaard, T. B., Calabrese, E., Johnson, G. A., & Bjaalie, J. G. (2014). Waxholm Space atlas of the Sprague Dawley rat brain. NeuroImage, 97, 374-386, [DOI: j.neuroimage.2014.04.001](https://doi.org/10.1016/j.neuroimage.2014.04.001).  

# PENDIENTES  
1. Montar el directorio con los archivos en /ernst  
1. Pipeline y pruebas para el corregistro no lineal con el atlas (voy a usar la menos y la más dañada como control)  

# Preprocesamiento Estructural  
## 1. Reorientacion de las Imagenes  
Los siguientes pasos se implementaron en el script `MRI_corregistro`
``` bash

# Cambiar dimension voxeles de la sequencia de RESTING STATE (rsFMRI)
# Voxel size (x10)
ls */*rsfMRI_*E?.nii.gz | parallel fslchpixdim  {} 1.17 1.17 12

### BET Estructural T2 
# Reorienta los sujetos con respecto que al atlas
ls */*_T2_Turbo*E?.nii.gz | cut -d . -f 1 | parallel fslswapdim {} x y z {}_sw

# Extraer cerebro
for i in $(ls */*T2_Turbo*_sw.nii.gz);do
	echo $i; 
	fslchpixdim  $i 1.17 1.17 6
	j=$(echo $i | cut -d . -f 1);
	center=$(cluster -i $i -t 10 | sed -n '2{p;q}' | awk '{print int($7)" "int($8)" "int($9)}');

	bet ${i} ${j}_brain.nii.gz -r 75 -c $center -f 0.3 -g 0.25;
	#bet ${j}_brain.nii.gz ${j}_brain.nii.gz -r 75 -c $center -f 0.25 -g -0.25;

	fslchpixdim  $i 1.17 1.17 12
	fslchpixdim ${j}_brain.nii.gz  1.17 1.17 12

done
```  
  
## 3. Denoise  
Aquí se pueden utilizar un método basado en *non-local means* y *bias field correction* ya se encuentra implementado y libre, hay que checar este script [`denoiseN4`](https://github.com/rcruces/MRI_analytic_tools/blob/master/Freesurfer_preprocessing/denoiseN4). La documentación junto con otros métodos de *denoising* esta en este [link](https://sites.google.com/site/pierrickcoupe/softwares/denoising-for-medical-imaging).  
> **References for denoiseN4:**  
> - Tustison, N. J., Avants, B. B., Cook, P. A., Zheng, Y., Egan, A., Yushkevich, P. A., & Gee, J. C. (2010). N4ITK: improved N3 bias correction. IEEE transactions on medical imaging, 29(6), 1310-1320.  
> - P. Coupé, P. Yger, S. Prima, P. Hellier, C. Kervrann, C. Barillot. An Optimized Blockwise NonLocal Means Denoising Filter for 3-D Magnetic Resonance Images. IEEE Transactions on Medical Imaging, 27(4):425–441, 2008. [MRI denoising by Pierrick Coupé](https://sites.google.com/site/pierrickcoupe/softwares/denoising-for-medical-imaging/mri-denoising).  
  
  
 # Análisis de las IRM  
 Los siguentes pasos no son necesariamente secuenciales ya que pueden realizarse a la mismo tiempo. Sin embargo, se necesitan que ambos pasos para realizar cuantificaciones volumétricas de las lesiones y cambios pre/post.

## Segmentacion manual de las lesiones  
Se recomienda utilizar el programa [`mrtrix`](http://www.mrtrix.org/) con su visualizador [`mrview`](http://mrtrix.readthedocs.io/en/latest/reference/commands/mrview.html?highlight=mrview) para realizar ROIS manuales.  
NOTA: La segmentación debe ser realizada por la misma persona para mantener la variabilidad usuario-dependiente.  

Segmentación manual con el programa ITKskap. Se utilzan etiquetas independientes para cada estructura lesionada. Se obtienen las matrices con la segmentación y se cuantifica el volumen. 

## Corregistro no lineal  
Aquí hay que llevar las imagenes ya procesadas al atlas. En el caso de que se cuente con volúmenes pre y post lesion hay que llevar la imagen de post-lesion a la pre y la pre al espacio del altas.  
Programas recomendados: [Advance Normalization Tools ANTs](https://stnava.github.io/ANTs/), [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FSL).  

# Cuantificación y Estadística  
Esto es lo último, así que hasta que no este todo lo anterios no hay que por que preocuparse por esto aún.

# NOTAS:




