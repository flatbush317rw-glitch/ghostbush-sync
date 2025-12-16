const BASE_URL = "http://127.0.0.1:8080";

function qs(sel) { return document.querySelector(sel); }
function qsa(sel) { return Array.from(document.querySelectorAll(sel)); }

async function api(path, opts = {}) {
  const url = BASE_URL + path;
  const res = await fetch(url, {
    ...opts,
    headers: {
      "Content-Type": "application/json",
      ...(opts.headers || {})
    }
  });
  if (!res.ok) {
    const text = await res.text().catch(() => "");
    throw new Error(`HTTP ${res.status} ${res.statusText}: ${text}`);
  }
  return res.json().catch(() => ({}));
}

function bindTabs() {
  const tabs = qsa(".tab");
  const panels = qsa(".panel");
  tabs.forEach(t => {
    t.addEventListener("click", () => {
      tabs.forEach(x => x.classList.remove("active"));
      t.classList.add("active");
      const id = t.dataset.tab;
      panels.forEach(p => p.classList.remove("visible"));
      qs("#" + id).classList.add("visible");
    });
  });
}

async function loadAppointments() {
  const list = qs("#appointments-list");
  list.innerHTML = "<li>Loading...</li>";
  try {
    const data = await api("/api/appointments");
    list.innerHTML = "";
    if (!Array.isArray(data) || data.length === 0) {
      list.innerHTML = "<li>No appointments scheduled.</li>";
      return;
    }
    data.forEach(a => {
      const li = document.createElement("li");
      li.textContent = `${a.datetime} — ${a.client} • ${a.service}`;
      list.appendChild(li);
    });
  } catch (err) {
    list.innerHTML = `<li class="error">Failed to load: ${err.message}</li>`;
  }
}

function bindAppointmentForm() {
  const form = qs("#appointment-form");
  const fb = qs("#appointment-feedback");
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    fb.textContent = "Submitting...";
    fb.classList.remove("error");
    const payload = {
      client: form.client.value.trim(),
      service: form.service.value.trim(),
      datetime: form.datetime.value
    };
    try {
      await api("/api/appointments", {
        method: "POST",
        body: JSON.stringify(payload)
      });
      fb.textContent = "Appointment booked.";
      form.reset();
      await loadAppointments();
    } catch (err) {
      fb.textContent = `Error: ${err.message}`;
      fb.classList.add("error");
    }
  });
}

async function loadServices() {
  const list = qs("#services-list");
  list.innerHTML = "<li>Loading...</li>";
  try {
    const data = await api("/api/services");
    list.innerHTML = "";
    if (!Array.isArray(data) || data.length === 0) {
      list.innerHTML = "<li>No services configured.</li>";
      return;
    }
    data.forEach(s => {
      const li = document.createElement("li");
      li.textContent = `${s.name} — $${s.price}`;
      list.appendChild(li);
    });
  } catch (err) {
    list.innerHTML = `<li class="error">Failed to load: ${err.message}</li>`;
  }
}

async function loadClients() {
  const list = qs("#clients-list");
  list.innerHTML = "<li>Loading...</li>";
  try {
    const data = await api("/api/clients");
    list.innerHTML = "";
    if (!Array.isArray(data) || data.length === 0) {
      list.innerHTML = "<li>No clients found.</li>";
      return;
    }
    const search = qs("#client-search");
    const render = (q = "") => {
      list.innerHTML = "";
      data
        .filter(c => (c.name || "").toLowerCase().includes(q.toLowerCase()))
        .forEach(c => {
          const li = document.createElement("li");
          li.textContent = `${c.name} • ${c.phone || "no phone"} • last visit: ${c.lastVisit || "n/a"}`;
          list.appendChild(li);
        });
      if (list.children.length === 0) list.innerHTML = "<li>No matches.</li>";
    };
    render();
    search.addEventListener("input", () => render(search.value));
  } catch (err) {
    list.innerHTML = `<li class="error">Failed to load: ${err.message}</li>`;
  }
}

async function loadSyncStatus() {
  const box = qs("#sync-status");
  box.textContent = "Loading...";
  try {
    const data = await api("/api/sync/status");
    box.innerHTML = `
      <div><strong>Branch:</strong> ${data.branch || "unknown"}</div>
      <div><strong>Last commit:</strong> ${data.lastCommit || "n/a"}</div>
      <div><strong>Last sync:</strong> ${data.lastSync || "n/a"}</div>
    `;
  } catch (err) {
    box.textContent = `Failed to load: ${err.message}`;
  }
}

function bindSyncRefresh() {
  qs("#refresh-sync").addEventListener("click", loadSyncStatus);
}

async function boot() {
  bindTabs();
  bindAppointmentForm();
  bindSyncRefresh();

  // Preload visible panel data
  await Promise.all([
    loadAppointments(),
    loadServices(),
    loadClients(),
    loadSyncStatus()
  ]);
}

document.addEventListener("DOMContentLoaded", boot);
