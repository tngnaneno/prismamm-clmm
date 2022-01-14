import http from "node:http";

const PORT = Number(process.env.PORT || 3003);

const html = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>PrismAMM</title>
  <style>
    :root { --bg:#0b0a12; --ink:#f2eefc; --muted:#a89bc0; --accent:#9b6bff; }
    body { margin:0; min-height:100vh; font-family:"Segoe UI",system-ui,sans-serif; color:var(--ink);
      background: radial-gradient(800px 420px at 70% 0%, #2a1a4a, transparent), var(--bg); }
    main { max-width:720px; margin:0 auto; padding:4rem 1.25rem; }
    h1 { font-size:clamp(2.5rem,6vw,4rem); margin:0 0 .5rem; letter-spacing:-0.03em; }
    p { color:var(--muted); line-height:1.6; font-size:1.1rem; }
    .cta { display:inline-block; margin-top:1.5rem; padding:.85rem 1.2rem; background:var(--accent);
      color:#120a22; text-decoration:none; font-weight:700; border-radius:8px; }
  </style>
</head>
<body>
  <main>
    <h1>PrismAMM</h1>
    <p>Concentrated-liquidity AMM for EVM L2s. Capital-efficient swaps, flash liquidity, and LP position NFTs.</p>
    <a class="cta" href="/health">Check health</a>
  </main>
</body>
</html>`;

const server = http.createServer((req, res) => {
  if (req.url?.startsWith("/health")) {
    res.writeHead(200, { "content-type": "application/json" });
    res.end(JSON.stringify({
      ok: true,
      service: "prismamm",
      feeTiers: ["0.01%", "0.05%", "0.30%", "1.00%"],
    }));
    return;
  }
  res.writeHead(200, { "content-type": "text/html; charset=utf-8" });
  res.end(html);
});

server.listen(PORT, () => {
  console.log(`[prismamm] server running at http://localhost:${PORT}`);
});
