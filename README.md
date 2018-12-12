# Master Thesis

This repository shows the research realised to conclude my degree at University of São Paulo in Aeronautical Engineering.
The objective of the project is to measure the displacement field of a flexible wing using a unique camera at root of the wing.

This technique can be used in wind tunned by having a camera directly attached to the root. It could also be used in flight tests using a camera inside the airplane.

In our experimental set up we have 2 cameras:
- a root camera to aquire the images (camera 1)
- a back camera to compare the estimated displacement (camera 2)

## Installation 

You need to have Matlab licence to run the program (I developped using Matlab 2016a).

## How to run

To reproduce the result in my report you need to:
- download the picture in the folder [data](data). You can download a zip file [here](https://www.dropbox.com/s/r0g8mv4aoy1d8y1/camera.zip?dl=0)
- run the main script ([main.m](src/main.m)). It will call the different parts of the analysis.

## Results

The final report for my university can be found [here](report/main_report.pdf). 

## Step of the analysis

I will brifely go through the different step of the report. 
If you need to more detailed explanation you can directly consult the report.

We have 5 main steps in the program: 
1) Image processing of the root camera pictures
2) Point ordering and filtering from the root camera pictures
3) Image processing of the back camera pictures
4) Point filtering from the back camera pictures
5) Comparison of the 2 displacement fields

### 1) Image processing of the root camera pictures

We need first to identify the chessboard corner from the image like the following example.

![Alt text](/readme_image/step1/img01substep1.jpg?raw=true "Original Image")

After the image processing, the chessboard corner are the white points and we just have to identify the center of the centroids like in the following image. 

![Alt text](/readme_image/step1/img01substep8.jpg?raw=true "Result Image")

### 2) Point ordering and filtering from the root camera pictures

Once we have all the points, we need to order them and delete false posifives. 
Indeed as shown in the next plots, they are ranked based on the x coordinates, not by columns. 
Moreover we have some points which are obviously wrong.

![Alt text](/readme_image/step2/1orderingPoints_original.jpg?raw=true "Unfiltered points")

After the filtering, we have the points seperated per column and the same number of points per column. 

![Alt text](/readme_image/step2/ordered_points.jpg?raw=true "Filtered points")

This step was way trickier that I initially thought.

### 3) Image processing of the back camera pictures

We need to process the image from the back camera to get the position of the displacement at the edge of the wing.  

![Alt text](/readme_image/step3/image_back.jpg?raw=true "Image with identified edge")

### 4) Point filtering from the back camera pictures

We also smoothed the points from the back camera.

![Alt text](/readme_image/step4/displacement_sum_up.jpg?raw=true "Unfiltered points")

### 5) Comparison of the 2 displacement fields

We can finally compare the results of both diplacement fields, one from the root camera and one from the back camera. 

We plotted the result for 3 different scenarios. 
Firstly, we used used the result without any calibration. 
Secondly, we use a calibration just with the tip of the wing. 
Thirdly, we use a calibration on the full displacement.

#### a. No calibration

![Alt text](/readme_image/step5/case1without_cal.jpg?raw=true "No Calibration")

#### b. Calibration with the tip of the wing

![Alt text](/readme_image/step5/case1tip_cal.jpg?raw=true "No Calibration")

#### c. Calibration with the full wing displacement 
![Alt text](/readme_image/step5/case1full_cal.jpg?raw=true "No Calibration")