const express = require('express');
const puppeteer = require('puppeteer');

const app = express();
const port = process.env.PORT || 3000;

async function startBrowser() {
    let browser;
    try {
        console.log("Opening the browser......");
        browser = await puppeteer.launch({
            headless: true, // Important : mode headless sur Render
            ignoreDefaultArgs: ["--disable-extensions"],
            args: [
                "--no-sandbox",                    // Évite les problèmes de sandbox
                "--use-gl=egl",                    // Utile pour le rendu sur certains serveurs
                "--disable-setuid-sandbox",
                "--disable-dev-shm-usage",         // Réduction consommation mémoire
                "--disable-accelerated-2d-canvas",
                "--disable-gpu",
                "--window-size=1920x1080",
            ],
            ignoreHTTPSErrors: true,
        });
        const page = await browser.newPage();
        await page.setUserAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36"); // User-Agent
        return { browser, page };
    } catch (err) {
        console.log("Could not create a browser instance => : ", err);
        return null;
    }
}

app.get('/', async (req, res) => {
    const session = await startBrowser();
    if (!session) {
        res.send('Erreur lors du lancement du navigateur.');
        return;
    }

    const { browser, page } = session;
    await page.goto('https://google.com', { waitUntil: 'domcontentloaded' });
    const title = await page.title();

    await browser.close();
    res.send(`Titre de la page : ${title}`);
});

app.listen(port, () => {
    console.log(`Serveur démarré sur le port ${port}`);
});
