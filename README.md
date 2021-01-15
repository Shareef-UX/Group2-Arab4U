*Al-Muta’alm*
Arab4U Mobile App

1. *Introduction:*
This app helps the students to have the opportunity to learn the Native Arabic language (Fusha) by providing the user with many materials such as videos and slides.

2. *Problem Statement* 
Some students cannot find the material that would guide them to learn the Arabic language in the right way and, they cannot pay for some premium course on the online platforms. In addition, there are many people who want to learn how to read the Quran correctly, and they have difficulties to read it. From this point, the project will solve these problems by providing some materials that can help in solving these problems.

3. *Target Audience*
-	Non-Arabic people who want to learn Arabic.
-	Those who cannot read the Quran (Arab/Non-Arab).

4. *Project Objectives*
-	Providing Free Materials.
-	Helping non-Arab people to learn the Arabic language.
-	Helping people to read the Qura'an correctly.

5. *Functionalities*
-	Sign in, sign up, and Logout
By using firebase packages, we implemented authentication features for the singing up and logging to the application. We implemented all the checking errors and provide the user an immediate feedback when something wrong happens to make the application robust against all the errors could be committed by the users when they want to get access to the application.


-	User Profile and Edit Profile
After users successfully register to the application, they will have a profile that contains all their information that they entered when they submitted the registration form. In the profile, user can update their information when needs be, and change their profile image. We used the Image_picker plugin to enable us in allowing the user to choose image from the gallery or the camera to be used for the profile picture. Also, we used the permission_handlers plugin to ask users when they first use the application to get permission to access to their camera and gallery when they pick and upload images.

-	Users Lessons and Learning Materials
Users can go through the video lessons listed for them according to their level, whether beginner, intermediate or advanced. To implement this, we used Youtube_player_flutter plugin the helps us to provide YouTube videos in the application.
-	Download materials
Users can download the learning materials and save them in their phone so they can revise the lessons and access it when they do not have internet connection. We will use the flutter_downloader plugin to make all different type of materials to be downloaded by users.
-	Storage for materials
All the materials provided to users will be stored inside Firebase Cloud Storage. So, whenever users access the materials, the materials will retrieved form the storage. We used Firebase_storage plugin to help store all the materials.
-	Adding Material by the Admin
Admins controls users and provide the lessons for them. Admins can add any file type for the users, like PowerPoint and PDF files. To develop this feature, we used File_picker that enable admins to pick and upload files for users.
-	Delete users by the Admin
Admins can delete users when the user is not active or decided not to continue the lesson or they terminated their account and no longer want to use the application.


-	*Most reusable widgets are used in this app:*
ListView.
TextFormField.
Container.
Column.
Row.
Card.
StreamBuilder.
ListTile.




*Activity Diagram*

![activity diagram](https://github.com/Shareef-UX/Group2-Arab4U/blob/main/Activity%20Diagram.png)

*Sequence Diagram*

![sequence diagram](https://github.com/Shareef-UX/Group2-Arab4U/blob/main/Sequence%20Diagram.png)
  
*Screen Navigation*

![Screen nav1](https://github.com/Shareef-UX/Group2-Arab4U/blob/main/Screen%20Nav%201.png)

![Screen nav2](https://github.com/Shareef-UX/Group2-Arab4U/blob/main/Screen%20Nav%202.png)
 


 


7. *Conclusion*
"Arab4U" is an application that facilitates the process of learning the Arabic language and reading the Qura'an throughout well-organized materials in video tutorials for the users. The ultimate goal of the project is to develop an application that can provide all the necessary and basic knowledge that users need to speed up the process of learning the Arabic language and mastering how to read and recite the Qura'an in a correct way.


*Work Delegation*

Tengku Ebar Syarif Hamzah	1628959:	
•	Develop the Registration page.
•	Activity Diagram
•	Work on the report.
• Create sequence diagram.

GABER AMER ABDULLAH SALEH	1629925:	
•	Develop the manage students page which makes the admin can be able to delete any student.
•	Develop the choose materials which lets the admin can be able to add materials such as Youtube URL and some documents.
•	Develop the view materials page with the three categories pages for Beginners, Intermediate, and Advanced. 
•	Create a sequence diagram.
•	Work on the report.

Issa Mahamat Issa Ahmat	1526367:
•	Develop the log in page
•	Develop the user profile page
•	Develop the user Update profile
•	Create the Screen Navigation Diagram for Users and Admins
•	Work on the report.
• Retrieve data from cloud firestore.
