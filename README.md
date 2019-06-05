# MKS22X-FinalProject
Instructions:
This is a photo booth, and is pretty self-explanatory. Just click the buttons to navigate to where you want to go, and if you want to take a picture, then click the button that says "Take Picture"! 
Here are just a few notes on the various sliders, and where images are saved:

Threshold - This slider affects both Edge-Detect and Colored Pencil. The lower the threshold, the darker/more colorful the resulting image will be.

Cartoon Threshold - This slider ONLY affects the cartoon filter. The lower the number, the darker the image will be.

Strands - Strands only affects the posterize filter. It determines how many mixtures of colors will be used when the image is filtered.

How to Use Backdrop: There is only one backdrop, which is a sunset scene. It is meant to be a BLUE SCREEN, where the user will stand infront of a blue background. Then, he must click THREE TIMES on the blue background, which will then be replaced by the backdrop image.

Saved Images: Saved images are placed in a folder marked "data" withtin the sketch folder. Please keep in mind that each time the program is run again, the images are replaced.



<b> DevLog: </b>

Monday, May 20: <br>
Elias Ferguson: I began to experiment with getting the Processing screen to display data from the webcam. Vishwaa ultimately achieved this first, and what I did was reverse the displayed image to make it mirror exactly. I created a new branch to begin work on the capture of a photo. <br>
Vishwaa Sofat: Created the display and setup such that the camera image could be displayed on the screen. Then worked with Elias to make the reverese function that displays image correctly.
<br>

Tuesday, May 21: <br>
Elias Ferguson: Starting to mess with ControlP5, specifically trying to make a Bang to take a picture. <br>
Vishwaa Sofat: Created the first filter: grayscale. Was not able to figure out how to display the updated picture but began debugging. Started writing code for the edgeDetect filter in the meantime. <br>

Wednesday, May 22:<br>
Elias Ferguson: Got the program to save the current image to the Sketch file, but the camera stops after one photo.<br>

Thursday, May 23:<br>
Elias Ferguson: Taking pictures now fully works. The camera only shutters for a brief second, and the photos are saved to a new directory that is inside Sketch, called PhotoBoothPhotos. Merging with the master branch.<br>
Vishwaa Sofat: Tried to resolve the overlapping display but wasn't able to fully figure it out.<br>

Friday, May 24:<br>
Elias Ferguson: I am starting with more controlP5 to give the user more autonomy and ability to edit photos. The primary concern is the interface right now, and any buttons that go along with it. I started shaping the screen to display 8 previews, each with a different filter.<br>
Vishwaa Sofat: Figured out how to display image with grayscale filter and fixed code to get rid of overlapping images. Went on to finish all the filters: grayscale, edgedetect, thermal, invert (xray), posterize, cartoon and pencil. Assinged each filter to one key, while Elias finished controlP5 buttons.<br>

Sunday, May 26:<br>
Vishwaa Sofat: Read ControlP5 documentation because Mr. K told us both to be familiar with all components of the code. <br>
Elias Ferguson: Learned how the filters worked, for the most part.

Monday, May 27:<br>
Elias Ferguson: I finished the previews, WITHOUT the filters applied. That, however, is the easy part. I merged with the master branch successfully and now the master fully works with a slightly updated user interface.<br>

Tuesday, May 28: <br>
Elias Ferguson: Today was mostly spent learning some more ControlP5 and figuring out what I will use in my User Interface, and how it will generally be laid out. I drew a few diagrams on graph paper, which may or may not be the final layouts.
Vishwaa Sofat: Fixed the way posterize functions by making a global variable instead of local variable for the posterize filter. Created a beach filter that allows user to click three times to select three pixels and replaces displayed pixels with a beach image. Still need to find a better picture but filter works properly. Started experimenting with face detection using openCV to create more advanced filters.<br>

Wednesday, May 29:<br>
<b> GITHUB DID NOT ALLOW US TO COMMIT OR PUSH BECAUSE OF OVERUSING DATA WITH A LIBRARY ZIP FILE. WORK WAS STILL DONE -- REFER TO MAY 30. </b><br>

Thursday, May 30:
Elias Ferguson: I tried to fix several bugs, including with the excessive lag and that pictures weren't being saved with the filters applied. I was unsuccessful with all of these bug fixes. I made a new branch to being working on a new User Interface as well. I did all the coordinate math and know what I will be doing over the weekend.

From May 31-June 3, I was dealing with medical issues and didn't make any commits. -Elias Ferguson

Tuesday, June 4:
Elias Ferguson: I made up all of my work for the past four days. I made a mode screen to show previews for the different filters. ControlP5 bangs now regulate switches between filters. The most important bug, that filtered photos weren't saved correctly, was fixed. More ControlP5 was added to give the user more autonomy with the Threshold, which affects several filters. Finished the project.
