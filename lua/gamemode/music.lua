-- music.lua
function PlayMusic(track)
    if !IsValid(track) then
        track = CreateSound(Entity(0), "path/to/your/music/file.wav")
    end
    track:Play()
end

function StopMusic(track)
    if IsValid(track) then
        track:Stop()
    end
end

-- You can call PlayMusic in SetDayTime, SetNightTime, or specific events
function SetDayTime()
    print("Daytime!")
    StopMusic() -- Stop any previous music
    PlayMusic("path/to/day/music.wav")
    SetGlobalBool("IsDay", true)
end

function SetNightTime()
    print("Nighttime!")
    StopMusic()
    PlayMusic("path/to/night/music.wav")
    SetGlobalBool("IsDay", false)
end
