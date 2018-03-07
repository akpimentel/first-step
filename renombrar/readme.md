`cat` Imprime un archivo  de texto en la terminal  
`while read` Lee cada linea de un texto impreso  
`awk` Separa testo impreso en campos  
# Renombrar Multiples Objetos `bash`  
  
### Ejemplo
```bash
cat /misc/ernst/rcruces/git_here/first-step/MRI_Rename | while read line; do 
f1=`echo $line | awk -F " " '{print $1}'`
f2=`echo $line | awk -F " " '{print $2}'`
mv -v $f1 $f2.nii.gz; done
```
