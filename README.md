# Análisis de las IRM Estructurales de Rata  
En este repositorio vamos a guardar los pasos así como los scripts necesarios para realizar el preprocesamiento básico y el análisis estructural de las imágenes estructurales pesadas a T2 de rata para detectar lesiones.  
1. [`databases`]() Contiene las bases de datos referentes a las identidicaciones, volumetria etc.   
1. [`mrat_preproc`](https://github.com/akpimentel/first-step/blob/master/mrat_preproc) Es necesario realizar un preprocesamiento semi-automatizado que incluya, reorientación, máscara del cerebro, homogenización de las intensidades y mejora en de la calidad señal ruido.
1. [`countROI.R`](https://github.com/akpimentel/first-step/blob/master/countROI.R) Posteriormente una segmentacion manual de la lesion sobre la imágen de alta resolución procesada y cuantificación del volumen.  
1. [`mrat_nii2atlas`](https://github.com/akpimentel/first-step/blob/master/mrat_nii2atlas) Finalmente se realizara un corregisto al atlas [Waxholm Space Atlas of the Sprague Dawley (WHS-SD)](https://www.nitrc.org/projects/whs-sd-atlas).  
1. [`mrat_fmri`](Preprocesamiento de resonancia magnetica funcional para rata)

> **NOTA:** Idealmente se deberían tener dos imagenes por sujeto-rata, una pre y una post lesion para un mejor corregistro entre ellas, para estimar las deformaciones estructurales producidas por la lesion y para mejorar el corregistro no lineal al atlas WHS-SD.  
> **Referencia del atlas:**  
> - Papp, E. A., Leergaard, T. B., Calabrese, E., Johnson, G. A., & Bjaalie, J. G. (2014). Waxholm Space atlas of the Sprague Dawley rat brain. NeuroImage, 97, 374-386, [DOI: j.neuroimage.2014.04.001](https://doi.org/10.1016/j.neuroimage.2014.04.001).  
> - Valdes PA, Sumiyoshi A, Nonaka H, Haga R, Aubert E, Ogawa T, Iturria Y, Riera JJ, Kawashima R
    "An in vivo MRI template set for morphometry, tissue segmentation and fMRI localization in rats" [DOI: 10.3389/fninf.2011.00026](https://www.frontiersin.org/articles/10.3389/fninf.2011.00026/full).

# Contenido  
1. [Preprocesamiento Estructural](#preprocesamiento-estructural)
1. [Segmentacion manual de las lesiones y volumetría](#segmentacion-manual-de-las-lesiones-y-volumetria)
1. [Corregistro no lineal a Atlas](#corregistro-no-lineal-a-atlas)
1. [Pendientes](#pendientes)

# 1. Preprocesamiento Estructural: `mrat_preproc`  
Los siguientes pasos se implementaron en el script `mrat_preproc`  
1. Copia el archivo original  
1. Cambia la resolución de los voxeles x10  
1. Calcula en centroide de la imagen y genera una mascara binaria basada en él.  
1. Aplica limpieza de ruido con non-local means de Pierrick coupe.  
1. Biasfield correction de ANTs  
  
### Info: Denoise  
Aquí se pueden utilizar un método basado en *non-local means* y *bias field correction* ya se encuentra implementado y libre, hay que checar este script [`denoiseN4`](https://github.com/rcruces/MRI_analytic_tools/blob/master/Freesurfer_preprocessing/denoiseN4). La documentación junto con otros métodos de *denoising* esta en este [link](https://sites.google.com/site/pierrickcoupe/softwares/denoising-for-medical-imaging).  
> **References for denoiseN4:**  
> - Tustison, N. J., Avants, B. B., Cook, P. A., Zheng, Y., Egan, A., Yushkevich, P. A., & Gee, J. C. (2010). N4ITK: improved N3 bias correction. IEEE transactions on medical imaging, 29(6), 1310-1320.  
> - P. Coupé, P. Yger, S. Prima, P. Hellier, C. Kervrann, C. Barillot. An Optimized Blockwise NonLocal Means Denoising Filter for 3-D Magnetic Resonance Images. IEEE Transactions on Medical Imaging, 27(4):425–441, 2008. [MRI denoising by Pierrick Coupé](https://sites.google.com/site/pierrickcoupe/softwares/denoising-for-medical-imaging/mri-denoising).  
  

# 2. Segmentacion manual de las lesiones y volumetría: `countROI.R`  
Se recomienda utilizar el programa [`mrtrix`](http://www.mrtrix.org/) con su visualizador [`mrview`](http://mrtrix.readthedocs.io/en/latest/reference/commands/mrview.html?highlight=mrview) para realizar ROIS manuales.  
NOTA: La segmentación debe ser realizada por la misma persona para mantener la variabilidad usuario-dependiente.  

Segmentación manual con el programa ITKskap. Se utilzan etiquetas independientes para cada estructura lesionada. Se obtienen las matrices con la segmentación y se cuantifica el volumen. 

# 3. Corregistro no lineal a Atlas: `mrat_nii2atlas`  
Aquí hay que llevar las imagenes ya procesadas al atlas. En el caso de que se cuente con volúmenes pre y post lesion hay que llevar la imagen de post-lesion a la pre y la pre al espacio del altas.  
Programas recomendados: [Advance Normalization Tools ANTs](https://stnava.github.io/ANTs/), [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FSL).  

# 4. Procesamiento de datos de Resonancia Funcional: `mrat_fmri`  


# PENDIENTES  
1. Montar el directorio con los archivos en /ernst  
1. Pipeline y pruebas para el corregistro no lineal con el atlas (voy a usar la menos y la más dañada como control) ¿Cuál es?  






