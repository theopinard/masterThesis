# Master Thesis

This repository shows the research realised to conclude my degree at University of Sao Paulo in Aeronautical Engineering.
The objective of the project is to measure the displacement field of a flexible wing using a unique camera at root of the wing.
This technique can be used in wind tunned by having a camera directly attached to the root. It could also be used in flight test using a camera inside the airplane.
In our experimental set up we have 2 cameras:
- a root camera to aquire the images
- a back camera to compare our result

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
3) Image processing of the picture of the back camera
4) Point filtering of the back camera
5) Comparison of the 2 displacement fields

### 1) Image processing of the root picture to identify chess corner.

We need to identify the chessboard corner using the 
![Alt text](/readme_image/step1/img01substep1.jpg?raw=true "Original Image")

After the image processing, the chessboard corner  we just have to identify the centroid in this image. 
![Alt text](/readme_image/step1/img01substep8.jpg?raw=true "Result Image")

We then can save the centroids coordinates.

### 2) Point ordering and filtering of the root camera

Once we have all the points, we need to order them and delete false posifive. 
Before filtering they are ranked based on the corrdinates, not by columns. Moreover we need to delete.

![Alt text](/readme_image/step2/1orderingPoints_original.jpg?raw=true "Unfiltered points")

After the filtering, we broke up the points per column and we have the same number of points per column.

![Alt text](/readme_image/step2/1orderingPoints_final.jpg?raw=true "Filtered points")

### 3) Image processing of the picture of the back camera

We need to process the image from the back camera to get the position of the displacement at the edge of the wing.  
![Alt text](/readme_image/step3/image.jpg?raw=true "Imge with identified edge")

### 4) Point filtering of the back camera

We also need to filter the points from the back camera to smooth it.
![Alt text](/readme_image/step4/displacement_sum_up.jpg?raw=true "Unfiltered points")

### 5) Comparison of the 2 displacement fields

We can finally compare the result of both diplacement field, one from the root camera and one from the back camera. 

We plotted the result for 3 different scenario. 
First we used used the result without any calibration. 
Second we use a calibration just with the tip of the wing. 
Third we use a calibration on the full displacement.

#### No calibration
![Alt text](/readme_image/step5/case1without_cal.jpg?raw=true "No Calibration")
#### Calibration just with the tip of the wing
![Alt text](/readme_image/step5/case1tip_cal.jpg?raw=true "No Calibration")
#### calibration with the full wing displacement 
![Alt text](/readme_image/step5/case1full_cal.jpg?raw=true "No Calibration")