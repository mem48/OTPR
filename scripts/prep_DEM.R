# Clean OS Data an create DEM

#settings

folder.in = "D:/Users/earmmor/OneDrive - University of Leeds/Routing/terr50_gagg_gb/data"
folder.out = "F:/dem"
folder.tmp = "F:/tmp"

# libs
library(raster)

files = list.files(folder.in, recursive = T, full.names = T)
dir.create(folder.tmp)



for(i in 1:length(files)){
  message(paste0(Sys.time()," doing ",files[i]))

  # unzip and find the asc file
  unzip(files[i],exdir=folder.tmp)
  files.tmp = list.files(folder.tmp, full.names = T, pattern = ".asc")
  files.tmp = files.tmp[!grepl(".xml",files.tmp)]
  raster.name = sub(".asc","",files.tmp)
  raster.name = sub(paste0(folder.tmp,"/"),"",raster.name)
  r = raster(files.tmp)
  #rasterlist[[i]] = r

  writeRaster(r,filename = paste0(folder.out,"/",raster.name,".tif"), overwrite=TRUE)
  file.remove(list.files(folder.tmp, full.names = T, recursive = T))
  
}

rasterlist <- list()
files = list.files(folder.out, recursive = T, full.names = T)
for(i in 1:length(files)){
  message(paste0("doing ",files[i]))
  r = raster(files[i])
  rasterlist[[i]] = r
}


# make master raster
rasterOptions(tmpdir="F:/tmp")
rasterOptions(chunksize=1e+08)
rasterOptions(maxmemory=1e+10)
rasterlist$filename <- "F:/dem/national4.tif"
rasterlist$overwrite <- TRUE
merged <- do.call(merge, rasterlist)

#writeRaster(merged3,filename = "F:/otp2/graphs/current/gbDEM.tif", overwrite=TRUE)
#crs(merged3)
newproj = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
merges.proj = projectRaster(merged, crs=newproj)
writeRaster(merges.proj,filename = "F:/otp2/graphs/current/gbDEM.tif", overwrite=TRUE)
