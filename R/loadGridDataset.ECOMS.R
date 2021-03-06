#' Loads a user-defined subset of a gridded CDM dataset
#' 
#' Loads a user-defined subset from a gridded dataset compliant with the Common
#'  Data Model interface
#' 
#' @author J. Bedia \email{joaquin.bedia@@gmail.com}
#' @references \url{http://www.unidata.ucar.edu/software/thredds/current/netcdf-java/tutorial/GridDatatype.html}

loadGridDataset.ECOMS <- function(var, grid, dic, level, season, years, time, latLon) {
      timePars <- getTimeDomain(grid, dic, season, years, time)
      levelPars <- getVerticalLevelPars.ECOMS(grid, level)
      mdArray <- makeSubset(grid, timePars, levelPars$zRange, latLon)
      if (!is.null(dic)) {
            isStandard <- TRUE
            mdArray <- dictionaryTransformGrid(dic, timePars, mdArray)
      } else {
            isStandard <- FALSE
      }
      if (isTRUE(latLon$revLat)) {
            mdArray <- revArrayLatDim(mdArray, grid)
      }
      return(list("Variable" = list("varName" = var, "isStandard" = isStandard, "level" = levelPars$level),
            "Data" = mdArray,
            "xyCoords" = latLon$xyCoords, 
            "Dates" = timePars$dateSlice))
}
# End
    
    


