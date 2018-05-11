# Clean OS Data an create DEM

#settings

folder.in = "D:/Users/earmmor/OneDrive - University of Leeds/Routing/terr50_gagg_gb/data"
folder.out = "F:/dem"
folder.tmp = "F:/tmp"

# libs
library(raster)

files = list.files(folder.in, recursive = T, full.names = T)

for(i in 1:length(files)){
  message(paste0(Sys.time()," doing ",files[i]))
  dir.create(folder.tmp)
  # unzip and find the asc file
  unzip(files[i],exdir=folder.tmp)
  files.tmp = list.files(folder.tmp, full.names = T, pattern = ".asc")
  files.tmp = files.tmp[!grepl(".xml",files.tmp)]
  raster.name = sub(".asc","",files.tmp)
  raster.name = sub(paste0(folder.tmp,"/"),"",raster.name)
  r = raster(files.tmp)
  writeRaster(r,filename = paste0(folder.out,"/",raster.name,".tif"), overwrite=TRUE)
  file.remove(list.files(folder.tmp, full.names = T, recursive = T))
  
}
