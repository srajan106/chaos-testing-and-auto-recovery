let lastState = true;

async function refresh() {

    try {
        let response = await fetch("http://localhost:5000/health");
        let data = await response.json();

        // Detect recovery
        if (lastState === false) {
            document.getElementById("status").innerText = "Recovered ✅";
            document.getElementById("status").style.color = "green";
        } else {
            document.getElementById("status").innerText = data.status;

            // Color based on status
            if (data.status === "Healthy") {
                document.getElementById("status").style.color = "green";
            } else {
                document.getElementById("status").style.color = "orange";
            }
        }

        lastState = true;

        document.getElementById("time").innerText = data.time;
        document.getElementById("recoveries").innerText = data.recoveries;
        document.getElementById("load").innerText = data.server_load + "%";

    } catch (error) {

        lastState = false;

        document.getElementById("status").innerText = "DOWN ❌";
        document.getElementById("status").style.color = "red";

        document.getElementById("time").innerText = "-";
        document.getElementById("recoveries").innerText = "-";
        document.getElementById("load").innerText = "-";
    }
}

// 🔥 Chaos trigger
function triggerChaos() {
    fetch("http://localhost:5000/chaos")
        .then(() => alert("Chaos triggered! Server will crash 💥"))
        .catch(() => alert("Server already down (expected)"));
}

// Initial call
refresh();

// Auto refresh every 3 seconds
setInterval(refresh, 3000);