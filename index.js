import https from 'https';
import http from 'http';

export const handler = async (event) => {
  const url = event?.url || process.env.TARGET_URL;

  if (!url) {
    console.error("TARGET_URL environment variable not set");
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "TARGET_URL not set" })
    };
  }

  const isHttps = url.startsWith('https');
  const client = isHttps ? https : http;

  try {
    const responseTime = await checkWebsite(client, url);

    return {
      statusCode: 200,
      body: JSON.stringify({
        url,
        status: "UP",
        responseTime,
        timestamp: new Date().toISOString()
      })
    };

  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({
        url,
        status: "DOWN",
        error: error.message,
        timestamp: new Date().toISOString()
      })
    };
  }
};

function checkWebsite(client, url) {
  return new Promise((resolve, reject) => {
    const start = Date.now();

    const req = client.get(url, (res) => {
      const responseTime = Date.now() - start;

      if (res.statusCode >= 200 && res.statusCode < 400) {
        resolve(responseTime);
      } else {
        reject(new Error(`Status code: ${res.statusCode}`));
      }
    });

    req.on('error', (err) => reject(err));
    req.setTimeout(8000, () => {
      req.destroy();
      reject(new Error("Request timed out"));
    });
  });
}

// ---- Local Test (ONLY for running locally) ----
if (process.argv[1].includes('index.js')) {
  handler({ url: "https://google.com" })
    .then(res => {
      console.log("\n✅ Local Test Result:");
      console.log(JSON.parse(res.body));
    })
    .catch(err => {
      console.error("\n⚠️ Local Test Error:");
      console.error(err);
    });
}
