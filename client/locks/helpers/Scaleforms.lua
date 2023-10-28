Helpers.Scaleforms = {}


--
-- Request ScaleformMovie and Return it
-- 
function Helpers.Scaleforms.LoadMovie(name)
    local scaleform = RequestScaleformMovie(name)
    while not HasScaleformMovieLoaded(scaleform) do Wait(0); end
    return scaleform
end

--
-- Request ScaleformMovieInteractive and Return it
-- 
function Helpers.Scaleforms.LoadInteractive(name)
    local scaleform = RequestScaleformMovieInteractive(name)
    while not HasScaleformMovieLoaded(scaleform) do Wait(0); end
    return scaleform
end

--
-- Unload Scaleform
--
function Helpers.Scaleforms.UnloadMovie(scaleform) 
    SetScaleformMovieAsNoLongerNeeded(scaleform)
end


