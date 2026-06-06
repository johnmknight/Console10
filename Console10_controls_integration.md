# Console10 — Controls & Integration Notes

The software side of Console10: coordinating **TouchOps virtual controls** (the touch panel),
the **Pi 5 touch display**, and **physical inputs** into one glass-cockpit / mission-control surface.
Most actions ride the homelab **MQTT** bus or hit **Home Assistant** webhooks. This file collects the
techniques for wiring a tap/press to a real action.

---

## Firing an action from a TouchOps tap — windowless HTTP / HA webhook (VBS solution)

**Goal:** a TouchOps tab (or a physical button mapped to one) fires a fire-and-forget action — e.g. an
HA webhook to toggle a light, run a scene, switch a screen — **with no console/PowerShell window flash**.

### Why the obvious paths flash (or don't run)
A TouchOps "launch" tab calls `app:launch`, whose main process handler resolves the target in this order
(`TouchOps/src/main.js`):
1. **URL / protocol** (`http://…`, `steam://…`) → `shell.openExternal` (opens the OS default — a browser
   for an `http` URL, which pops a window).
2. **An existing file on disk** → `shell.openPath` (opens it with its **default handler**).
3. **Anything else (a bare command or a command line with args)** → `cp.spawn(target, { shell: true })`.

So:
- Pointing a tab at a bare **`.ps1`** path → step 2 → opens the script **in an editor** (Windows' default
  "open" for `.ps1` is *edit*, not *run*). It doesn't execute.
- Pointing a tab at **`powershell -File …`** (a command line) → step 3 → `cp.spawn` runs it through
  `cmd.exe` (`shell:true`) with `windowsHide:false`, so a **console window flashes** even with
  `-WindowStyle Hidden`.

### The fix: a `.vbs` run by `wscript` (windowless)
Point the launch tab at a **`.vbs` file path** (step 2 → `shell.openPath`). The default handler for `.vbs`
is **`wscript.exe`, a GUI-subsystem (windowless) host** — so it runs the script with **no window at all**.
The script does the HTTP GET directly via `MSXML2.XMLHTTP`, so PowerShell is never involved.

```vbs
' Fire an HA webhook silently (no window). Run by wscript (the default .vbs handler).
On Error Resume Next                      ' a momentary HA outage never pops a dialog
Dim http
Set http = CreateObject("MSXML2.XMLHTTP.6.0")
http.Open "GET", "http://homeassistant.local:8123/api/webhook/<your_webhook_id>", False
http.Send
```

**TouchOps launch-tab config** — point at the `.vbs` *file path* (not a command line), so `openPath` runs it:
```json
{ "title": "Office Light", "launch": true, "icon": "bulb", "color": "#e8a020",
  "url": "C:\\Users\\john_\\.dotnet\\tools\\OfficeLightToggle.vbs" }
```

Working reference: `C:\Users\john_\.dotnet\tools\OfficeLightToggle.vbs` (office-light HA webhook toggle),
first used 2026-06-06.

### Notes / caveats
- Runs on whatever machine TouchOps runs on (the PC), so the target host (`homeassistant.local`, a Pi,
  etc.) must be reachable from there.
- Relies on the Windows default that `.vbs` **runs** on open (true unless `.vbs` was remapped to an editor).
- `On Error Resume Next` keeps it truly fire-and-forget — no blocking, no error dialog. Use a synchronous
  GET (`False`) for a quick webhook; the script exits as soon as the request is sent.
- For an **MQTT** action instead of HTTP, prefer publishing from a small always-running bridge and have
  the tab just hit a webhook/endpoint that publishes — VBS has no clean MQTT client.

---

*Started 2026-06-06. Add Console10 controls/integration techniques here as they're worked out.*
