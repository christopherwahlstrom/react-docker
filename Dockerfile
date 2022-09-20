FROM node:lts-alpine

#Skapa en mapp "app" inuti Docker image
# /app blir aktuell mapp (när man skriver . senare i filen)
WORKDIR /app

#Kopiera package.json -> in till mappen app i en image
COPY package*.json ./

# Installerar npm-paket
RUN npm install 

#Kopiera över all koden från aktuell mapp på datorn -> till /app i image
COPY . .


RUN npm run build

# Gör port 8080 synlig utåt
EXPOSE 8080

# Starta en webbserver som servar de statiska filerna i /app/dist
# alternativ server: Nginx
CMD ["http-server", "dist"]

