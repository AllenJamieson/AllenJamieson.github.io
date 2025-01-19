let player = document.getElementById("player");
let img_capture_btn = document.getElementById("img_capture");
let dot_lbl = document.getElementById("dot_label");
let canvas = document.getElementById("canvas");

access_camera();
img_capture_btn.addEventListener("click", capture);

function access_camera() { // TODO check to see how to use outer camera
    navigator.mediaDevices.getUserMedia({video:true})
    .then(stream => {
        player.srcObject = stream
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

async function count_dots(img, width, height) { // TODO Param tweek and see if this is the same
    //cv.resize(img, img, new cv.Size(width/4, height/4), cv.INTER_AREA);
    cv.cvtColor(img, img, cv.COLOR_RGB2BGR);

    let params = new cv.SimpleBlobDetector().getParams()
    params['thresholdStep'] = 5
    let detector = new cv.SimpleBlobDetector(params)
    let keypoints = new cv.KeyPointVector()
    detector.detect(img, keypoints)    
    dot_lbl.textContent = keypoints.size();
    cv.drawKeypoints(img, keypoints, img)

// TODO use the original image and grow the key?
    //cv.resize(img, img, new cv.Size(width, height), cv.INTER_LINEAR)
    cv.cvtColor(img, img, cv.COLOR_RGB2BGR)
    cv.imshow(canvas, img)
}