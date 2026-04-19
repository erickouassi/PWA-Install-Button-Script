if ("serviceWorker" in navigator) {
  window.addEventListener("load", async () => {
    try {
      const reg = await navigator.serviceWorker.register("/sw.js");
      console.log("Service worker registered successfully:", reg.scope);
    } catch (err) {
      console.error("Service worker registration failed:", err);
    }
  });
}
