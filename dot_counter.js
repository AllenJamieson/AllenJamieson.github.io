let player = document.getElementById("player");
let img_capture_btn = document.getElementById("img_capture");
let dot_lbl = document.getElementById("dot_label");
let canvas = document.getElementById("canvas");
let settings_btn = document.getElementById("settings_btn");
let settings_div = document.getElementById("settings");
let submit = settings_div.getElementsByTagName("button")[0];

let bool_settings = [
    'collectContours', 'filterByArea', 'filterByCircularity',
    'filterByColor', 'filterByConvexity', 'filterByInertia'
];
let numeric_settings = [
    'blobColor', 'maxArea', 'maxCircularity',
    'maxConvexity', 'maxInertiaRatio', 'maxThreshold',
    'minArea', 'minCircularity', 'minConvexity',
    'minDistBetweenBlobs', 'minInertiaRatio', 'minRepeatability',
    'minThreshold', 'thresholdStep'
];

let params, detector;
let scale = 1, color = -1;

access_camera();
setTimeout(init, 2500); // Creates a delay so that the opencv loads completely

settings_div.style.visibility = "hidden";
settings_btn.addEventListener("click", _=> settings_div.style.visibility = "visible");
submit.addEventListener("click", settings);

function init() {
    try {
        img_capture_btn.addEventListener("click", capture);
        params = new cv.SimpleBlobDetector().getParams();
        detector = new cv.SimpleBlobDetector();
        console.log(cv);
        console.log(params);
    } catch(err) {
        img_capture_btn.disabled = true;
        settings_btn.disabled = true;
    // TODO alert causes the timeout to show a violation in the handler
        alert("There is an issue connecting to opencv. Try refreshing, if it still is an issue contact me.");
    }
}

// https://stackoverflow.com/questions/72420950/how-to-switch-between-front-camera-and-rear-camera-in-javascript
// https://www.digitalocean.com/community/tutorials/front-and-rear-camera-access-with-javascripts-getusermedia
function handleVideo() {
    return {
        video: {
            width: { max: window.innerWidth },
            height: { max: window.innerHeight },
            facingMode: { exact: "environment" }
        }
    };
}

function access_camera() {
    navigator.mediaDevices.getUserMedia(handleVideo())
    .then(stream => {
        player.srcObject = stream;
        let {width, height} = stream.getVideoTracks()[0].getSettings();
        player.width = width;
        player.height = height;
    }).catch(_=> {
        img_capture_btn.disabled = true;
        alert("Need a forward facing camera to continue.");
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
        let src = new cv.Mat(player.height, player.width, cv.CV_8UC4);
        new cv.VideoCapture(player).read(src);
        count_dots(src, player.width, player.height);
    }
}

async function count_dots(img, width, height) {
    cv.resize(img, img, new cv.Size(width/scale, height/scale), cv.INTER_AREA);
    if(color != -1) cv.cvtColor(img, img, color);
// TODO Other parameters if the image needs to be with things that I am unaware of
    let keypoints = new cv.KeyPointVector();
    detector.detect(img, keypoints);
    dot_lbl.textContent = keypoints.size();
    cv.drawKeypoints(img, keypoints, img);
    cv.resize(img, img, new cv.Size(width/2, height/2), cv.INTER_LINEAR);
    cv.imshow(canvas, img);
}

function settings() {
    let in_params = settings_div.getElementsByClassName("numeric_setting");
    let bool_params = settings_div.getElementsByClassName("bool_setting");
    
    for (let bs = 0; bs < numeric_settings.length; bs++)
        if(in_params[bs].value != "" && !isNaN(in_params[bs].value))
            params[numeric_settings[bs]] = parseFloat(in_params[bs].value);

    for (let ns = 0; ns < bool_settings.length; ns++)
        params[bool_settings[ns]] = bool_params[ns].checked;
    
    detector = new cv.SimpleBlobDetector(params);
    settings_div.style.visibility = "hidden";

    let scale_div = document.getElementById("scaler");
    if(scale_div.value != "" && !isNaN(scale_div.value)) scale = parseInt(scale_div.value);
    let color_div = document.getElementById("color");
    if(scale_div.value != "" && !isNaN(scale_div.value)) color = parseInt(color_div.value);

    console.log(params);
}