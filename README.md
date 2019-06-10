# MKS22X-FinalProject
<br>
Group Members: Elias Ferguson and Vishwaa Sofat <br>
Project Description:
Our project is an effort to recreate the photo booth found on Apple computers. The controls are pretty self-explanatory and the you should be able to just click the buttons to navigate to where you want to go or what you want to do.

Instructions:<br>
1. Clone the repository. <br>
2. CD into the PhotoBooth folder. <br>
3. Open the PhotoBooth.pde file. <br>
4. Make sure you have all the neccessary libraries downloaded: OpenCV, Processing Video and controlP5. <br>
5. Click the "run" button. <br>

At this point you should be able to see a picture of yourself on the screen. Move around. Raise your hand(s) and you'll see the camera display whatever you do! <br>

<b> Picture Taking Mode: <b>

In this mode you can take a picture, mess around with the brightness, hue and saturation, and try out one of our filters.<br>

<br>

What does each slider/button do? <br>

Threshold - This slider affects the following filters: Edge-Detect, Colored Pencil, Cartoon, and Posterize. The threshold changes what the image will look like, test it out to see the differences between high and low.

Brightness, Hue and Saturation: These sliders all change different aspects of the image, based on processing.org documentation. If you don't like the changes just click on "Reset Sliders" to revert back to the original.

Reset Sliders: This button sets brightness, hue and saturation to 0 to display the orginal image. 

Take Picture: Well, you guessed it! This button captures the image.

See Filters: This will lead you to our filters display mode, where you can pick one of our many filters.


-- 

How to Use Backdrop: There is only one backdrop, which is a sunset scene. It is meant to be a COLOR REPLACEMENT SCREEN, where the user will stand infront of a uniformly colored background, such as a blue wall. Then, they must click THREE TIMES on that background, which will then be replaced by the backdrop image.

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

Thursday, May 30:<br>
Elias Ferguson: I tried to fix several bugs, including with the excessive lag and that pictures weren't being saved with the filters applied. I was unsuccessful with all of these bug fixes. I made a new branch to being working on a new User Interface as well. I did all the coordinate math and know what I will be doing over the weekend.<br>
Vishwaa Sofat: I worked out of the facial branch mostly from here on out because we had completed our basic and advanced filters. I was able to get eye, nose and facial detection working using openCV but there was extreme lag so I wasn't able to do a lot of testing.<br>

From May 31-June 3, I was dealing with medical issues and didn't make any commits. -Elias Ferguson <br>

May 31 - June 3:<br>
Vishwaa Sofat: I tried resolving the issue with lag but couldn't do much because Elias and I had figured out that our previews were causing a lot of the delays. I had to wait until we switched to the mode version to tweak filters that I had worked on as neccessary for previews and pictures. <br>

Tuesday, June 4 - Wednesday, June 5:<br>
Elias Ferguson: I made up all of my work for the past four days. I made a mode screen to show previews for the different filters. ControlP5 bangs now regulate switches between filters. The most important bug, that filtered photos weren't saved correctly, was fixed. More ControlP5 was added to give the user more autonomy with the Threshold, which affects several filters. Finished the project. <br>
Vishwaa Sofat: Once Elias had the mode preview set up, I was able to fix bugs with the cartoon and replacement filters. For cartoon, I had to make a new slider and variable along with adding more code to fully inherit the pixels we requied for the filters. For the replacmeent filter, I For cartoon, I also helped out with adjusting the previews for cartoon because it only showed a black scren earlier. Elias and I both attempted paint but weren't able to finish it. I continued working on facial recongnition because I got really obssessed with it and found a way to slightly implement it on our final version. <br>

Friday, June 7: <br>
Elias Ferguson and Vishwaa Sofat: Went to CS office during 6th period to look at bug that didn't allow access to camera and gave a message suggesting the device was busy and being used. Modified code to no longer use two Capture but instead make a copy of the main Capture (cam), which would allow us to display different images for our displays but stemming from the same main image. This did not resolve any issues. We went to the CS Dojo/office after 10th period until around 5:30. We compared old versions that worked on the school computers and were able to resolve the bug. Elias later pushed code that we were certain worked on the computers at school based on our testing. <br>

Saturday, June 8: <br>
Elias Ferguson: I made it so that after a photo is taken it isn't saved right away. An edit screen was implemented, where the user can choose to scrap or to save the photo, as well as edit it in various ways. I almost fully successfully implemented paint() as well, but the problem is that when the image is saved the paint disappears. I'll address that issue tomorrow. <br>
Vishwaa Sofat: I created methods that allowed the user to change the brightness, saturation and hue using the HSB mode in processing. The variables for these methods were connected to sliders and get methods that changed the values. I also created a flower trail feature, based on mouse coordinates and angles created by movement, that would be added to our editing mode. This is an extension of the paint method that Elias and I had previosuly written. I also added the pointilize feature, which recreates the images through circles based on colors found at random locations. This feature is to also be added to our editing mode.

Sunday: June 9: <br>
Elias Ferguson: Paint and flowers work well, as does pointilize. The images are saved with them on it now. We successfully implemented pixel changing based on saturation, hue, and brightness sliders. It all works well. Deleted some sliders in favor of one slider. Fixed ThermalScreen. <br>
Vishwaa Sofat: Set up proportions to get rid of Cthreshold and strands slider to make layout nearter. Set up those variables based on threshold slider. Redesigned layout for controls to mae it neater and easier to use for users. Changed CP5 control names to fit design. Fixed facial recognitions output by reversing x values based on screen size. Also, fixed pointlize to reverse x values based on screen size. Helped Elias fix hue, brightness and saturation based on implementation the day before.

<br>
<br>

<b> WE MADE IT! </b>
