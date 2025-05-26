FROM node:18-slim

RUN apt-get update && \
    apt-get install -y \
    git \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libnspr4 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    chromium \
    openssh-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# 👇 Copie ton code local dans l'image Docker
COPY . .

RUN npm install

EXPOSE 3000

CMD ssh -o StrictHostKeyChecking=no -R 80:localhost:3000 serveo.net & node index.js
