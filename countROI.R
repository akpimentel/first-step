# ######################################################## #
#               Cuenta voxeles de ROIs
# ######################################################## #
# Carga la libreria que lee niftis
library(oro.nifti)

# Determina el directorio de trabajo
setwd("/misc/ernst/rcruces/database/ratas/TurboRARE")

# Carga el archivo con las etiquetas
nii <- readNIfTI("000.nii.gz")

# Cuenta los voxeles de cada etiqueta única
total <- table(nii@.Data)

# Resolución de los pixeles
pix.res <- nii@pixdim[2:4]/10

# Volumen real de cada voxel en mm³
voxvol <- prod(pix.res)

print("TOTAL DE VOXELES:")
total

print("TOTAL VOLUMEN:")
total*voxvol

