import cv2
from tkinter import filedialog

def sobel_detect(image):
    x = cv2.Sobel(image, cv2.CV_64F, 1, 0)
    y = cv2.Sobel(image, cv2.CV_64F, 0, 1)
    mag = cv2.magnitude(x, y)
    return cv2.convertScaleAbs(mag)

INPUT_PATH = filedialog.askopenfilename(initialdir=".", filetypes=(("mp4", "*.mp4*"), ("webm", "*.webm*")))
FRAME_WIDTH = 640
FRAME_HEIGHT = 480

if not INPUT_PATH: quit()
cap = cv2.VideoCapture(INPUT_PATH)
fps = cap.get(cv2.CAP_PROP_FPS)

fourcc = cv2.VideoWriter_fourcc(*"mp4v")
out = cv2.VideoWriter(INPUT_PATH.split(".")[0] + "_edges.mp4", fourcc, fps, (FRAME_WIDTH, FRAME_HEIGHT))

while True:
    ret, frame = cap.read()
    if not ret: break
    resize = cv2.resize(frame, (FRAME_WIDTH, FRAME_HEIGHT), interpolation=cv2.INTER_AREA)
    grayed = cv2.cvtColor(resize, cv2.COLOR_BGR2GRAY)
    converted = sobel_detect(resize)
    out.write(converted)

cap.release()
out.release()