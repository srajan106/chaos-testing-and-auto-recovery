let lastState = true;

async function refresh() {
    try {
        let response = await fetch("http://localhost:5000/health");
        let data = await response.json();

        // Status
        if (lastState === false) {
            document.getElementById("status").innerText = "Status: Recovered";
        } else {
            document.getElementById("status").innerText = "Status: " + data.status;
        }

        lastState = true;

        document.getElementById("time").innerText = "Time: " + data.time;
        document.getElementById("recoveries").innerText =
            "Recoveries: " + (data.recoveries ?? 0);
        document.getElementById("load").innerText =
            "Load: " + data.server_load + "%";

    } catch (error) {
        lastState = false;
        document.getElementById("status").innerText = "Status: DOWN";
    }
}

// 🔥 CHAOS FUNCTION (IMPORTANT)
async function triggerChaos() {
    try {
        await fetch("http://localhost:5000/chaos");
    } catch (error) {
        console.log("Chaos triggered");
    }
}

refresh();
setInterval(refresh, 3000);