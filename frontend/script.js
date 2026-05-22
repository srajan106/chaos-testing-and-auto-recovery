async function refresh(){

try{

let response =
await fetch(
"http://localhost:5000/health"
);

let data=
await response.json();

document.getElementById(
"status"
).innerText=
"Status: "+data.status;

document.getElementById(
"time"
).innerText=
"Time: "+data.time;

document.getElementById(
"recoveries"
).innerText=
"Recoveries: "+data.recoveries;

document.getElementById(
"load"
).innerText=
"Load: "+data.server_load+"%";

}
catch(error){

document.getElementById(
"status"
).innerText=
"Backend connection failed";

console.log(error);

}

}

refresh();

setInterval(
refresh,
3000
);