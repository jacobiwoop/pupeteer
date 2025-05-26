# Utilise une image Node.js officielle
FROM node:22.14.0-slim

# Installe les dépendances système nécessaires pour Puppeteer et Chromium
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
    libgbm1 \  # <=== Ajoute cette ligne
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Crée le dossier de l'application
WORKDIR /app

# Initialise le projet Node.js
RUN npm init -y

# Installe puppeteer et express
RUN npm install puppeteer express

# Copie les fichiers de l'application
COPY . .

# Expose le port
EXPOSE 3000

# Commande de démarrage
CMD ["node", "index.js"]
