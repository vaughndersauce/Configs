---
version: '2'
services:
  sabnzbd:
    image: linuxserver/sabnzbd
    container_name: sabnzbd
    volumes:
      - /share/Multimedia/Docker_Configs/sabnzbd:/config
      - /share/Multimedia/:/mnt
      - /share/Multimedia/:/downloads
    restart: always
    environment:
      - TZ=America/New_York
    ports:
      - 32779:8080
      - 32778:9090
  sonarr:
    image: linuxserver/sonarr:preview
    container_name: sonarr
    depends_on:
      - sabnzbd
    volumes:
      - /share/Multimedia/Docker_Configs/sonarr:/config
      - /share/Multimedia:/mnt
      - /share/Multimedia:/downloads
    environment:
      - TZ=America/New_York
    ports:
      - 32770:8989
  radarr:
    image: linuxserver/radarr:nightly
    container_name: radarr
    depends_on:
      - sabnzbd
    volumes:
      - /share/Multimedia/Docker_Configs/radarr:/config
      - /share/Multimedia/:/mnt
      - /share/Multimedia:/downloads
    environment:
      - TZ=America/New_York
    ports:
      - 32771:7878
  hydra:
    image: linuxserver/nzbhydra2
    container_name: nzbhydra
    volumes:
      - /share/Multimedia/Docker_Configs/hydra:/config
      - /share/Multimedia:/mnt
    restart: always
    environment:
      - TZ=America/New_York
    ports:
      - 32783:5076
  readarr:
    image: hotio/readarr:nightly
    container_name: readarr2
    volumes:
      - /share/Multimedia/Docker_Configs/readarr:/config
      - /share/Multimedia/:/downloads
    restart: always
    environment:
      - TZ=America/New_York
      - PUID=1000
      - GUID=100
    ports:
      - 32780:8787
  mylar:
    image: linuxserver/mylar
    container_name: mylar
    environment:
      - PUID=1000
      - PGID=100
    volumes:
      - /share/Multimedia/Docker_Configs/mylar:/config
      - /share/Multimedia/Comics:/comics
      - /share/Multimedia:/downloads
    ports:
      - 32790:8090
    restart: unless-stopped