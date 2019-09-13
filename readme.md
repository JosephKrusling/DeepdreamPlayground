# Deepdream - Comparison of CPU and GPU Processing
Joseph Krusling

2019-09-11

Prepared for CS 5168

## Introduction
For my "embarrassingly parallel" demonstration, I chose to run Google Deepdream in Jupyter according to the demonstration here: https://github.com/google/deepdream/blob/master/dream.ipynb

## Installation and Deployment
Google's Deepdream depends on the Caffe deep learning framework, which proved exceptionally difficult to install. It requires a ton of poorly versioned C libraries and is quite finicky about CUDA versions.

After spending many (5+) hours trying to install Caffe directly onto a VM in Google Cloud, I decided to create a Docker image based on the officially provided Caffe images and use that instead. This image adds a Jupyter server, as well as volume bindings to import my models, data, and notebooks.

I chose to explore Deepdream using Jupyter running on a fairly high-power instance on Google Cloud. I attached an NVIDIA Tesla K80 to the VM to perform the comparison between CPU and GPU. Google cloud made it fairly simple to provision a VM with working NVIDIA drivers and CUDA, so I just had to install nvidia-docker and run my Docker container.

## Demo
After 8+ total hours of fiddling, I finally got the example code from Google's notebook to work correctly.

Using the code in my notebook (see notebooks/deepdream.ipynb) I was able to generate images such as the following in a pretty reasonable amount of time.

### Here's how I look on a good day
![me normally](https://i.imgur.com/BKoGQP7.jpg)

### And here's how I look on a _REALLY_ good day.
![me dreamin' hard](https://i.imgur.com/SkJVRD4.jpg)

## Performance
It's fortunately quite easy to switch between using CPU-only or GPU acceleration using Caffe, so obtaining benchmarks was no problem.

Benchmarks were performed using Jupyter on a Google Cloud VM with 4 vCPUs, 15 GB of memory and 1 NVIDIA Tesla K80.

The benchmark consisted of performing the default Deepdream code on a 182x158 pixel image of Pikachu. All times are in seconds.

| Trial | CPU Only      | GPU           |
|-------|---------------|---------------|
| 1     | 11.5642619133 | 1.62579798698 |
| 2    | 11.0189261436 | 1.611369133   |
| 3     | 10.9254310131 | 1.61122298241 |
| 4     | 10.9863009453 | 1.61808490753 |
| 5     | 10.9531219006 | 1.62012815475 |

![normal pikachu](https://i.imgur.com/3nShZwr.jpg)
![dreamy pikachu](https://i.imgur.com/1ocNxrh.jpg)


## Discussion
Accelerating the code with the Tesla K80 improved dream time considerably, but not to the extent that I expected. These results correspond to about a 6-fold speedup, but I expected a speedup closer to 50-fold or 100-fold.

I think one potential reason for the smaller than expected speedup is the small resolution that I used for the test image. I think that the GPU would have an advantage on an image with considerably more pixels because of its ability to process more pixels simultaneously. For these small workloads, the CPU has a bit of an advantange because the fixed cost of running on a GPU is higher (compiling CUDA, etc.)