# Renombrar Multiples Objetos `bash`  

## Comandos de `bash`
`cat` Imprime un archivo  de texto en la terminal  
`while read` Lee cada linea de un texto impreso  
`awk` Separa texto impreso en campos  
  
## Ejemplo para renombrar todos los archivos
```bash
# Copia todo
cp */*TurboRAREhigh* ../TurboRARE/

# Cambia nombres
cat /misc/ernst/rcruces/git_here/first-step/renombrar/MRI_Rename | while read line; do 
f1=`echo $line | awk -F "," '{print $1}'`
f2=`echo $line | awk -F "," '{print $2}'`
mv -v $f1 $f2.nii.gz; done
```
