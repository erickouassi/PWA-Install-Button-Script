// PWA Install Button Script
/*  Add the below code to your HTML
  <!-- Independent Install Button -->
  <button id="installBtn" class="share-btn" style="display:none; margin-top:15px;">
    Download App
  </button>
*/

 (function () {
      let deferredPrompt;
      const installBtn = document.getElementById('installBtn');

      if (!installBtn || !('serviceWorker' in navigator)) return;

      window.addEventListener('beforeinstallprompt', (e) => {
        e.preventDefault();
        deferredPrompt = e;
        installBtn.style.display = 'block';
      });

      installBtn.addEventListener('click', async () => {
        if (!deferredPrompt) return;
        installBtn.style.display = 'none';
        deferredPrompt.prompt();
        const { outcome } = await deferredPrompt.userChoice;
        deferredPrompt = null;
      });

      window.addEventListener('appinstalled', () => {
        installBtn.style.display = 'none';
      });
    })();
