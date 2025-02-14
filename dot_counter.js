let dot_lbl = document.getElementById("dot_label");
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

setTimeout(init, 2500); // Creates a delay so that the opencv loads completely

settings_div.style.visibility = "hidden";
settings_btn.addEventListener("click", _=> settings_div.style.visibility = "visible");
submit.addEventListener("click", settings);

function init() {
    try {
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

function count_dots() {
    let img = new cv.Mat(player.height, player.width, cv.CV_8UC4);
    new cv.VideoCapture(player).read(img);
    cv.resize(img, img, new cv.Size(player.width/scale, player.height/scale), cv.INTER_AREA);
    if(color != -1) cv.cvtColor(img, img, color);
// TODO Other parameters if the image needs to be with things that I am unaware of
    let keypoints = new cv.KeyPointVector();
    detector.detect(img, keypoints);
    dot_lbl.textContent = keypoints.size();
    cv.drawKeypoints(img, keypoints, img);
    cv.resize(img, img, new cv.Size(player.width/2, player.height/2), cv.INTER_LINEAR);
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
    if(color_div.value != "" && !isNaN(scale_div.value)) color = parseInt(color_div.value);

    console.log(params);
}