#' @export
Prepare_User_Extrapolation_Data_Fn <-
function( input_grid, strata.limits=NULL, zone=NA, flip_around_dateline=TRUE, ... ){
  # Infer strata
  if( is.null(strata.limits)){
    strata.limits = data.frame('STRATA'="All_areas")
  }
  message("Using strata ", strata.limits)

  # Read extrapolation data
  Data_Extrap <- input_grid

  # Survey areas
  Area_km2_x = Data_Extrap[,'Area_km2']
  
  # Augment with strata for each extrapolation cell
  Tmp = cbind("BEST_LAT_DD"=Data_Extrap[,'Lat'], "BEST_LON_DD"=Data_Extrap[,'Lon'])
  if( "Depth" %in% colnames(Data_Extrap) ){
    Tmp = cbind( Tmp, Data_Extrap[,'Depth'] )
  }
  a_el = as.data.frame(matrix(NA, nrow=nrow(Data_Extrap), ncol=nrow(strata.limits), dimnames=list(NULL,strata.limits[,'STRATA'])))
  for(l in 1:ncol(a_el)){
    a_el[,l] = apply(Tmp, MARGIN=1, FUN=match_strata_fn, strata_dataframe=strata.limits[l,,drop=FALSE])
    a_el[,l] = ifelse( is.na(a_el[,l]), 0, Area_km2_x)
  }

  # Convert extrapolation-data to an Eastings-Northings coordinate system
  tmpUTM = Convert_LL_to_UTM_Fn( Lon=Data_Extrap[,'Lon'], Lat=Data_Extrap[,'Lat'], zone=zone, flip_around_dateline=flip_around_dateline)                                                         #$

  # Extra junk
  Data_Extrap = cbind( Data_Extrap, 'Include'=1)
  if( all(c("E_km","N_km") %in% colnames(Data_Extrap)) ){
    Data_Extrap[,c('E_km','N_km')] = tmpUTM[,c('X','Y')]
  }else{
    Data_Extrap = cbind( Data_Extrap, 'E_km'=tmpUTM[,'X'], 'N_km'=tmpUTM[,'Y'] )
  }

  # Return
  Return = list( "a_el"=a_el, "Data_Extrap"=Data_Extrap, "zone"=attr(tmpUTM,"zone"), "flip_around_dateline"=flip_around_dateline, "Area_km2_x"=Area_km2_x)
  return( Return )
}
