# DOC-OTG (Doctor On The Go)

_A Solution on Effective Ailment Analysis: Case Study on COVID during Pandemic_

## Introduction
DOC-OTG is a part of the research project of Sri Guru Gobind Singh College of Commerce and is a native mobile application for doctors to diagnose whether a patient is COVID-19 positive or not. The app takes 4 inputs from the patient, including Symptom Text, Image (X-Ray, CT-Scan, etc.), Audio, and Video. Machine learning algorithms at the backend analyze the input and provide a diagnosis report.

## Technologies Used
### Flutter:
> DOC-OTG has been developed using Flutter, which is an open-source mobile application development framework created by Google. Flutter enables developers to build high-performance, cross-platform mobile applications for iOS and Android using a single codebase.

### Dart Language:
> Dart is an object-oriented, class-based programming language used by Flutter to build user interfaces and create logic for mobile applications. Dart provides intuitive syntax and high performance.

### Firebase:
> Firebase is a cloud-based backend service provided by Google that enables developers to build mobile and web applications quickly without managing their infrastructure.

### Python Language:
> DOC-OTG uses Python, a high-level programming language, for developing the machine learning models. The machine learning models are trained on large datasets to predict whether a patient is COVID-19 positive or not.


## Patient-Side App Screens
> The app has four main screens for patients, which are described below.

### Log-in and Sign-up Page
> The login and signup page is the first screen of the app. Users can log in using their username and password or can create a new account by registering on this page.


Log-In Screen
Sign-Up Screen
Filled Sign-Up Screen
User Details Filled


### Home Page
> The home page is the second screen of the app. It displays two main sections. The first section contains the latest diagnosis reports of the patients. The second section contains past reports, which users can access by clicking on the "Past Reports" button. The home page also shows the list of doctors available for consultation.

Home Screen
Doctor List Screen


### Diagnosis Page
> The diagnosis page is the third screen of the app. It is used for taking all four inputs, including Symptoms Text, Image (X-Ray, CT-Scan, etc.), Audio, and Video. Users can upload these inputs using the respective options provided on the screen. Once the inputs are uploaded, machine learning algorithms analyze the data and provide a diagnosis report.






Input Screen
Input Screen
Result Screen Pending
Result Screen Verified


### Profile Page
> The profile page is the fourth and last screen of the app. It contains user information such as Name, Age, Gender, Nationality, and Phone Number. Users can update their information by clicking on the "Edit Profile" button.


Patient Profile Screen


## Doctor-Side App Screens
> The app also has four main screens for doctors, which are described below.

### Log-in and Sign-up Page
> The login and signup page is the first screen of the app. Doctors can log in using their username and password or can create a new account by registering on this page.




Log-In Screen
Sign-Up Screen
Filled Sign-Up Screen
User Details Filled

### Home Page
> The home page is the second screen of the app. It displays two main sections. The first section contains the list of patients assigned to the doctor. The second section contains the latest diagnosis reports of the patients assigned to the doctor. Doctors can access past reports of the patients assigned to them by clicking on the "Past Reports" button.




Doctor Home Screen
Past Reports Screen
Report Screen (Submitted Inputs)



### Diagnosis Page
> The diagnosis page is used for taking all four inputs, including Symptoms Text, Image (X-Ray, CT-Scan, etc.), Audio, and Video. Doctors can upload these inputs using the respective options provided on the screen. Once the inputs are uploaded, machine learning algorithms analyze the data and provide a diagnosis report.





Input Screen
Input Screen
Result Screen Pending
Result Screen Verified


### Profile Page
> The profile page is the fourth and last screen of the app. It contains doctor's information such as Name, Age, Gender, Nationality, and Phone Number. Doctors can update their information by clicking on the "Edit Profile" button.


Doctor Profile Screen


## App Workflow
> The app workflow for patients and doctors is as follows:

### For Patients
> 1. Patients log in or sign up using their credentials.
> 2. Patients land on the home page, where they can see the latest reports and the list of doctors available to them.
> 3. Patients can access their past reports by clicking on the Past Reports “see all” button on the home page.
> 4. Patients can navigate to the diagnosis page by clicking on the "Diagnosis" button on the home page navigation bar.
> 5. Patients can upload the four inputs, including Symptoms Text, Image (X-Ray, CT-Scan, etc.), Audio, and Video, on the diagnosis page.
> 6. The machine learning algorithms analyze the input and provide a diagnosis report.
> 7. Patients can access the diagnosis report on the home page.
> 8. Patients can edit their profile information on the Profile Page by clicking on the "Edit Profile" button.

### For Doctors
> 1. Doctors log in or sign up using their credentials.
> 2. Doctors land on the home page, where they can see the list of patients assigned to them and the latest reports of their patients.
> 3. Doctors can access past reports of their patients by clicking on the "Past Reports" button on the home page.
> 4. Doctors can navigate to the diagnosis page by clicking on the "Diagnosis" button on the home page navigation bar.
> 5. Doctors can upload the four inputs, including Symptoms Text, Image (X-Ray, CT-Scan, etc.), Audio, and Video, on the diagnosis page for themselves.
> 6, The machine learning algorithms analyze the input and provide a diagnosis report.
> 7. Doctors can access the diagnosis report of their patients and themselves on the home page.
> 8. Doctors can edit their profile information on the Profile Page by clicking on the "Edit Profile" button.

## Conclusion
> DOC-OTG is an innovative mobile application that uses machine learning algorithms to diagnose whether a patient is COVID-19 positive or not. The app provides a user-friendly interface for patients and doctors to access the diagnosis reports. The app has four main screens for patients and doctors, including Log-in and Sign-up Page, Home Page, Diagnosis Page, and Profile Page. The app workflow is well-organized and provides a seamless experience for users.


