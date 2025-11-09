:: Download YouTube trailers
:: Note: If downloading channel instead of playlist, use --playlist-end
@ECHO OFF

:: Set directory for files
SET "dir_anime="E:\Other\YouTube\Anime Trailers"
SET "dir_movies=E:\Other\YouTube\Movie Trailers"
SET "dir_tv_shows=E:\Other\YouTube\TV Show Trailers"

:: Set YouTube videos page/playlist urls to download
SET url_anime=https://www.youtube.com/@crunchyroll/videos
SET url_movies=https://www.youtube.com/@RottenTomatoesTRAILERS/videos
SET url_tv_shows=https://www.youtube.com/@RottenTomatoesTV/videos

:: MovieGasm https://www.youtube.com/playlist?list=PLB6y-bQdmqCEY0M_ExHt1Y9x76uQSxpOP
:: TV Promos https://www.youtube.com/playlist?list=PLfrisy2KXzkdY9Sw_kMcCnB1kf19_yZ40

SET format=bestvideo[height<=?720]+bestaudio/best[height<=?720]
:: SET format=bestvideo[height<=?1080]+bestaudio/best

SET max=50

:: Anime Trailers
CD %dir_anime%

yt-dlp -f "%format%" --match-filter "duration>30 & duration<300 & title~='(?i)\b(trailer)\b'" --playlist-end 1000 --merge-output-format mp4 --max-downloads %max% --break-on-existing --restrict-filenames --download-archive archive.txt -o "Anime Trailers - %%(title)s.%%(ext)s" %url_anime%

:: List all *.mp4 files by date in descending order, keep/skip latest X files, delete remaining files
for /f "skip=%max% eol=: delims=" %%F in ('dir /b /o-d /a-d *.mp4') do @del "%%F"



:: Movie Trailers
CD %dir_movies%

yt-dlp -f "%format%" --match-filter "duration>30 & duration<300 & title!~='(?i)\b(clip|scene)\b'" --playlist-end 100 --merge-output-format mp4 --max-downloads %max% --break-on-existing --restrict-filenames --download-archive archive.txt -o "Movie Trailers - %%(title)s.%%(ext)s" %url_movies%

:: List all *.mp4 files by date in descending order, keep/skip latest X files, delete remaining files
for /f "skip=%max% eol=: delims=" %%F in ('dir /b /o-d /a-d *.mp4') do @del "%%F"



:: TV Trailers
CD %dir_tv_shows%

yt-dlp -f "%format%" --match-filter "duration>30 & duration<300 & title!='(?i)\b(clip|scene)\b'" --playlist-end 100 --merge-output-format mp4 --max-downloads %max% --break-on-existing --restrict-filenames --download-archive archive.txt -o "TV Show Trailers - %%(title)s.%%(ext)s" %url_tv_shows%

:: List all *.mp4 files by date in descending order, keep/skip latest X files, delete remaining files
for /f "skip=%max% eol=: delims=" %%F in ('dir /b /o-d /a-d *.mp4') do @del "%%F"

EXIT /B