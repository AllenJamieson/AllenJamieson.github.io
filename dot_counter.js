let player = document.getElementById("player");
let img_capture_btn = document.getElementById("img_capture");
let dot_lbl = document.getElementById("dot_label");
let canvas = document.getElementById("canvas");
let settings_btn = document.getElementById("settings_btn");
let settings_div = document.getElementById("settings");
let submit = settings_div.getElementsByTagName("button")[0];

let params, detector;
let scale = 1;
let color = 4;

access_camera();
setTimeout(init, 5000); // Creates a delay so that the opencv loads completely
settings_div.style.visibility = "hidden"
settings_btn.addEventListener("click", _=> settings_div.style.visibility = "visible");
submit.addEventListener("click", settings);

function init() {
    img_capture_btn.addEventListener("click", capture);
    params = new cv.SimpleBlobDetector().getParams();
    detector = new cv.SimpleBlobDetector();
}

// https://stackoverflow.com/questions/72420950/how-to-switch-between-front-camera-and-rear-camera-in-javascript
function handleVideo(cameraFacing) {
    const constraints = {
        video: {
            facingMode: {
                exact: cameraFacing
            }
        }
    }
    return constraints;
}

function access_camera() { // TODO check to see how to use outer camera
    navigator.mediaDevices.getUserMedia(handleVideo("environment"))
    .then(stream => {
        player.srcObject = stream
        player.play();
        let {width, height} = stream.getVideoTracks()[0].getSettings()
        player.width = width;
        player.height = height;
    });
}

function capture() {
    if(img_capture_btn.textContent == "Back") {
        player.style.visibility = "visible";
        canvas.style.visibility = "hidden";
        img_capture_btn.textContent = "O";
    } else {
        player.style.visibility = "hidden";
        canvas.style.visibility = "visible"
        img_capture_btn.textContent = "Back";
        let src = new cv.Mat(player.height, player.width, cv.CV_8UC4);
        new cv.VideoCapture(player).read(src);
        count_dots(src, player.width, player.height);
    }
}

async function count_dots(img, width, height) {
    cv.resize(img, img, new cv.Size(width/scale, height/scale), cv.INTER_AREA);
    cv.cvtColor(img, img, color);
// TODO Other parameters if the image needs to be with things that I am unaware of
    let keypoints = new cv.KeyPointVector();
    detector.detect(img, keypoints);
    dot_lbl.textContent = keypoints.size();
    cv.drawKeypoints(img, keypoints, img);

    cv.resize(img, img, new cv.Size(width, height), cv.INTER_LINEAR)
    cv.imshow(canvas, img)
}

function settings() {
    // TODO create the settings for the parameters
    console.log("HI");
    let parameters = settings_div.getElementsByTagName("input")
    


    detector = new cv.SimpleBlobDetector(params);
    settings_div.style.visibility = "hidden"
}