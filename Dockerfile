# Utiliser une image Node.js officielle
FROM node:20-slim

# Installer les dépendances nécessaires pour Puppeteer
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
    libgbm1 \
    libxss1 \
    libgtk-3-0 \
    libxshmfence1 \
    --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Créer le dossier de l'application
WORKDIR /app

# Copier les fichiers du projet dans le conteneur
COPY . .

# Installer les dépendances Node.js (y compris Puppeteer)
RUN npm install

# Exposer le port (remplace 10000 par ton port si nécessaire)
EXPOSE 10000

# Commande pour démarrer ton application
CMD ["npm", "start"]
