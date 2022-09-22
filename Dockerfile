# Build context. Hämta Linux + Node

FROM node:lts-alpine

#Skapa en mapp "app" inuti Docker image
# /app blir aktuell mapp (när man skriver . senare i filen)
WORKDIR /app

# Installera webbservern vi ska använda i sista steget
# Man kan använda CMD ["npm", "run", "dev"] i stället men den startar den lokala utvecklingsservern.Utvecklingsservern är gjord för att felsöka , inte för att köra "produktionen".
RUN npm install -g http-server

#Kopiera package.json -> in till mappen app i en image
COPY package*.json ./

# Installerar npm-paket
RUN npm install 

#Kopiera över all koden från aktuell mapp på datorn -> till /app i image
COPY . .

# Bygg projektet - kör byggscriptet 
# Statiska filer (html, css, js) hamnar i /app/dist
RUN npm run build

# Gör port 8080 synlig utåt
EXPOSE 8080

# Starta en webbserver som servar de statiska filerna i /app/dist
# alternativ server: Nginx
# CMD körs när man startar containern
CMD ["http-server", "dist"]

