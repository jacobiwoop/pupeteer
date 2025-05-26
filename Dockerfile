# Utilise une image officielle Node.js
FROM node:22.14.0-slim

# Installe les dépendances nécessaires pour Chromium et Puppeteer
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Crée et passe dans le dossier de l'application
WORKDIR /app

# Copie les fichiers de l'application
COPY . .

# Installe les dépendances Node.js
RUN npm install

# Expose le port (si Express est utilisé, mettons 3000)
EXPOSE 3000

# Commande de démarrage
CMD ["node", "index.js"]
