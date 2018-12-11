# Master Thesis

This repository shows the research realised to conclude my degree at University of Sao Paulo in Aeronautical Engineering.

## Installation 

You need to have matlab to run the program (I developped using matlab 2016).
The pictures need to be downloaded and paste in the folder data. You can download a zip file here (https://www.dropbox.com/s/r0g8mv4aoy1d8y1/camera.zip?dl=0)

## Run the program

To run the program you just need to run the main script, tt will call the different parts of the analysis.

## Result

The final report can be found in the report folder. 

## Step of the analysis

I will brifely go through the different step of the report. If you need to more detailed explanation you can directly consult the report.

We have 5 main step in the program: 
1) Image processing of the root picture to identify chess corner.
2) Point ordering and filtering of the root camera
3) Image processing of the back camera
5) Point filtering of the back camera
5) Comparison of the 2 displacement fields

1) Image processing of the root picture to identify chess corner.

We need to identify the chessboard corner using the 
![Alt text](/readme_image/step1/img01substep1.jpg?raw=true "Original Image")

After the image processing we just have to identify the centroid in this image. 
![Alt text](/readme_image/step1/img01substep8.jpg?raw=true "Original Image")
