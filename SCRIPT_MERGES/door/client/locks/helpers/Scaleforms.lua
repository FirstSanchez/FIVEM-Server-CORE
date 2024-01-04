CreateThread(function()
    Helpers.Scaleforms = {}

    function Helpers.Scaleforms.LoadMovie(name)
        local scaleform = RequestScaleformMovie(name)
        while not HasScaleformMovieLoaded(scaleform) do Wait(0); end
        return scaleform
    end

    function Helpers.Scaleforms.LoadInteractive(name)
        local scaleform = RequestScaleformMovieInteractive(name)
        while not HasScaleformMovieLoaded(scaleform) do Wait(0); end
        return scaleform
    end

    function Helpers.Scaleforms.UnloadMovie(scaleform) 
        SetScaleformMovieAsNoLongerNeeded(scaleform)
    end
end)