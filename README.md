<h1 align="center">A Custom Approach to Retinal Vessel Segmentation on DRIVE Dataset</h1>
<p align="center">
<img src="path_to_image.png" alt="Retinal Vessel Segmentation Output" />
</p>
This repository contains a custom approach for retinal vessel segmentation on the DRIVE dataset. The project utilizes various advanced computer vision techniques, such as mathematical morphology, image enhancement, and segmentation algorithms to accurately identify and segment blood vessels in retinal images. This is crucial for the early diagnosis and treatment of various eye-related diseases like diabetic retinopathy.

### Main Methods Used:

1. **Mathematical Morphology:** Utilized morphological operations such as erosion and dilation to enhance the retinal images and remove noise.

2. **Image Enhancement:** Applied techniques like contrast adjustment, histogram equalization, and adaptive thresholding to improve the visibility of retinal vessels.

3. **Segmentation Algorithms:** Developed a custom algorithm to segment the retinal vessels from the background, using techniques such as edge detection, region growing, and watershed segmentation.

## Installation

1. Clone the repository using Git:
    ```
    git clone https://github.com/[username]/RetinaVesselExtractor.git
    ```

2. Install the required dependencies:
    - Python 3.x
    - NumPy
    - SciPy
    - OpenCV
    - Matplotlib

3. Import the necessary modules in your code:
    ```python
    import cv2
    import numpy as np
    import matplotlib.pyplot as plt
    from scipy import ndimage
    ```

## Usage

1. Prepare your input image by loading it using OpenCV:
    ```python
    image = cv2.imread("path_to_input_image.jpg")
    ```

2. Call the main vessel segmentation function with your input image:
    ```python
    output_image = segment_vessels(image)
    ```

3. Display or save the segmented output image:
    ```python
    cv2.imshow("Segmented Retinal Vessels", output_image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    ```

## License

This project is licensed under the MIT License.
