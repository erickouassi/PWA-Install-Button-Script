const staticDevPWA = "yourNameHere-v4.18.2026";
const assets = [
  "/",
  "/index.html",
  "/about.html",
  "/privacy_policy.html",
  "/offline.html", 
  "/style.css", 
  "/ui.js"
];

// 1. Install - Same as yours, but with self.skipWaiting()
self.addEventListener("install", installEvent => {
  installEvent.waitUntil(
    caches.open(staticDevPWA).then(cache => {
      return cache.addAll(assets);
    })
  );
  self.skipWaiting(); 
});

// 2. Activate - Cleanup old caches (Crucial for versioning)
self.addEventListener("activate", activateEvent => {
  activateEvent.waitUntil(
    caches.keys().then(keys => {
      return Promise.all(
        keys.filter(key => key !== staticDevPWA)
            .map(key => caches.delete(key))
      );
    })
  );
});

// 3. Fetch - With an offline fallback
self.addEventListener("fetch", fetchEvent => {
  fetchEvent.respondWith(
    caches.match(fetchEvent.request).then(res => {
      // Return cached asset, or try the network
      return res || fetch(fetchEvent.request).catch(() => {
        // If the network fails (offline) and they are navigating to a page
        if (fetchEvent.request.mode === 'navigate') {
          return caches.match("/offline.html");
        }
      });
    })
  );
});
