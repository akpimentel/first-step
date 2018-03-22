# ######################################################## #
#               Cuenta voxeles de ROIs
# ######################################################## #

#### FUNCION: CUENTA VOXELES X ROI ####
get.roi <- function(Nifti, escala) {
# Nifti   Es la dirección con nombre del archivo (character)
# escala  Es la escala de los voxeles (x10 x1 etc), tu tienes x10 Karen!
  # Carga la libreria que lee niftis
  require(oro.nifti)
  # Carga el archivo con las etiquetas
  nii <- readNIfTI(Nifti,reorient = FALSE)
  # Cuenta los voxeles de cada etiqueta única
  total <- table(c(nii@.Data))
  # Resolución de los pixeles
  pix.res <- nii@pixdim[2:4]/escala
  # Volumen real de cada voxel en mm³
  voxvol <- prod(pix.res)
  # Crea un vector con el ID y las dimensiones de voxel
  out <- as.data.frame(cbind(strsplit(Nifti, split='.', fixed=TRUE)[[1]][1],t(pix.res),voxvol,sum(total)))
  # Combina todo en un data.frame (df) de 1xN
  out <- cbind(out,t(matrix(total)))
  # Agrega lis nombres al df
  colnames(out) <- c("ID", "vox.x", "vox.y", "vox.z", "vox.vol","vox.n", names(total))
  # Salida
  return(out)  
}

# -------------------------------------------------------------------- #
# Determina el directorio de trabajo
setwd("/misc/ernst/rcruces/database/mica_epilepsia/tmp_volbrain")

# Guarda todos los niftis de la carpeta en un objeto
niftis <- list.files(pattern = "nii.gz")

# si siempre tienes las mismas etiquetas puedes iterar sobre todos los NIFTIS y concatenar las filas
# si las rois varian en numero hay que ver otra forma de concatenar
volumes <- c()
for (i in niftis) {
  print(paste0("[INFO]...Obteniendo volumenes de ",i))
  # corre la función y concatena el resultado
  volumes <- rbind(volumes,get.roi(i,1))
  }

# Guarda el df con los volumenes en un csv
write.csv(volumes,file = "/misc/ernst/rcruces/git_here/micasoft/sandbox/raul/figures_classes/figure2/cases_volumes.csv")
