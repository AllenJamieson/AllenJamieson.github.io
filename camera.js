// https://www.digitalocean.com/community/tutorials/front-and-rear-camera-access-with-javascripts-getusermedia
let player = document.getElementById("player");
let canvas = document.getElementById("canvas");
let img_capture_btn = document.getElementById("img_capture");
let cameraOptions = document.getElementById("custom-select");
let selection_btn = document.getElementById("select");

let constraints = {
    video: {
        width: { max: window.innerWidth },
        height: { max: window.innerHeight },
    }
};

setup_camera_select();
img_capture_btn.addEventListener("click", capture);
selection_btn.addEventListener("click", update_camera);

async function setup_camera_select() {
    let vid = (await navigator.mediaDevices.enumerateDevices()).filter(device => device.kind === 'videoinput');
    for await (const v of vid) {
        console.log(v);
        let opt = document.createElement("option");
        if(v.label ==="") opt.text = "Generic Camera"
        else opt.text = v.label;
        opt.value = v.deviceId;
        cameraOptions.add(opt);
    }
}

function update_camera() {
    let updated_constraints = {
        ...constraints,
        deviceId: {
            exact: cameraOptions.value
        }
    }; 
    navigator.mediaDevices.getUserMedia(updated_constraints)
    .then(stream => {
        player.srcObject = stream;

        // TODO find the actual size
        let {width, height} = stream.getVideoTracks()[0].getSettings();
        player.width = width;
        player.height = height;
    
        player.play();
    }).catch(err => {
        console.log(err);
        alert("There is an issue updating the camera");
    });    
}

function capture() {    
    if(img_capture_btn.textContent == "Back") {
        player.style.visibility = "visible";
        canvas.style.visibility = "hidden";
        img_capture_btn.textContent = "O";
    } else {
        player.style.visibility = "hidden";
        canvas.style.visibility = "visible";
        img_capture_btn.textContent = "Back";
        count_dots();
    }
}