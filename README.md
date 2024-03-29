# **WeatherDrobe**

## Purpose of this app

WeatherDrobe's purpose is to help in everyday situations in which we often don't have time to dress properly or check upcoming weather news. Did you ever have problem with time missing? This application has been created to sort it out. The Main Algorithm of WeatherDrobe will prepare for you few proposals of dressing, based on actual weather informations, whereby you will never again forget to take an umbrella ;)
>*All screenshots presented below do not represent the final state of the product. Appearance may change in the future.*
### *Home Page*
On the homepage, the user will be able to receive information such as suggested clothing, the current [weather forecast](#weather-api), and by pressing the top banner, the hourly weather forecast. In addition, in the left column there are suggestions such as umbrella, wristwatch, etc. *Do you like the look of this app?* [*Check Graphic Attribution!*](#graphic-attribution)
<div align='center'>
<img src="./github/img/home_screen%20(1).png"
     alt="Outfit Creator - Temperature"
     width="250" />
<img src="./github/img/home_screen%20(2).png"
     alt="Outfit Creator - Temperature"
     width="250"/>
     </div>



### *Virtual Wardrobe*

In the virtual wardrobe, users can browse their own collection, which is automatically downloaded from the Firebase server (Check [Data Fetching](#data-fetching)). When you click on a piece of clothing, informations about it appears on the screen. In the future we are also planning a function of editing and deleting the created clothes.
<div align='center'>
<img src="./github/img/virtual_wardrobe%20(1).png"
     alt="Outfit Creator - Temperature"
     width="250" />
<img src="./github/img/virtual_wardrobe%20(2).png"
     alt="Outfit Creator - Temperature"
     width="250"/>
     </div>

### *Outfit Creator*
The following images represent the appearance of the Outfit Creator. The user can easily create new clothing by setting four attributes - template, color, temperature and additional weather conditions. After pressing the 'Save' button, the information of the newly created outfit is sent to the Firebase server. Check [FireBase Data Sending](#data-sending) for more detailed informations.
<div align='center'>
<img src="./github/img/outfit_creator%20(1).png"
     alt="Outfit Creator - Temperature"
     width="250" />
<img src="./github/img/outfit_creator%20(2).png"
     alt="Outfit Creator - Temperature"
     width="250"/>
<img src="./github/img/outfit_creator%20(3).png"
     alt="Outfit Creator - Temperature"
     width="250"/>
<img src="./github/img/outfit_creator%20(4).png"
     alt="Outfit Creator - Temperature"
     width="250"/>
     </div>

## Weather API

WeatherDrobe's weather informations are based on [Open Weather Map API](https://openweathermap.org/api) which allows to use a powerfull [One Call API](https://openweathermap.org/api/one-call-api) option with the following feedback data:
* Current weather
* Minute forecast for 1 hour
* Hourly forecast for 48 hours
* Daily forecast for 7 days
* National weather alerts
* Historical weather data for the previous 5 days
* Current and forecast weat

Currently WeatherDrobe is using following data:
```dart
CurrentData({this.iconId, this.temperature, this.description, this.time});

  factory CurrentData.fromJson(dynamic json) {
    return CurrentData(
        iconId: json["weather"][0]["icon"],
        temperature: json["temp"].toDouble(),
        description: json["weather"][0]["description"],
        time: json["dt"]);
  }
```
```dart
HourlyForecast({this.iconId,this.temperature,this.description,this.propabilityOfPrecipitation,this.time});

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
        iconId: json["weather"][0]["icon"],
        temperature: json["temp"].toDouble(),
        description: json["weather"][0]["description"],
        propabilityOfPrecipitation: json["pop"].toDouble(),
        time: json["dt"]);
  }
```
## Firebase

WeatherDrobe is using Firebase Could Firestore databese to allows users multi-device experience. All garments created on one device will be available in another ones. (Provided that user will be on the same account)

#### *User authentication*

On the first run of application User is asked to create an account or Sign-in to an existing one. The following code is responsible for all authentication operations with Firebase server:


```dart
  //Logging in
  
  Future<void> signIn(String email, String password) async {
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
```
Checking changes in authentication states during the application run (Depending on status state, relevant data will be showed on User's screen):
    
  ```dart
Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      status = Status.Authenticated;
    }
    notifyListeners();
  }
```

```dart
//Registration

Future<void> register(String email, String password) async {
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
            print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
      }
    } catch (e) {
          print(e);
    }
}

//Logging out

    Future<void> signOut() async {
        await _auth.signOut();
    }
}
```
### *Storing data on the server*

In order to maintain clarity and speed of movement through the database, data should be entered in an appropriate manner.

When the User000 creates a garment with the following characteristics: 
1. Red hat
2. Best for 26°C — 29°C
3. Suitable for strong sun

The data would be stored in the following way:

![Data Storing](./github/img/Firebase_Storing_Data.png)


<!-- > * **Collection of Users**
>     - *User000*\
>       email: user000@example.com\
>       userID: YBDml5hjqTbcwwidb7922UGGhU03
>         -  **Headwear Collection**
>             -  *ID23of1newly9added321outfit2*\
>               dir: blank_hat_template_name\
>                   rain: false\
>                   snow: false\
>                   wind: false\
>                   sun: true\
>                   temperature: 7\
>                   color: 0xffd50000 -->
            
Since it would be highly inefficient to store two variables corresponding to minimum and maximum temperature, the following assignment of ranges to corresponding words and numbers was used in the process of storing the temperature data:
> 0:    -∞ — -10° = Freezing 
> 
> 1:     -9° — 0° = Cold 
> 
> 2:    1° — 4° = Chilly
> 
> 3:     5° — 8° = Brisk
> 
> 4:     9° — 13° = Cool
> 
> 5:    14° — 18° = Mild
> 
> 6:    19° — 25° = Perfect
> 
> 7:    26° — 29° = Warm
> 
> 8:    30° — 33° = Hot
> 
> 9:    34° — ∞° = Scorching

The above assignment of temperature to appropriate terms was borrowed from [u/_eurostep's post on Reddit](https://www.reddit.com/r/EnglishLearning/comments/7o8rdm/the_definitive_scale_of_english_adjectives_to/) (Last access 21.02.2020).


### *Data sending*

In WeatherDrobe, the user has the ability to add new garments to their Virtual Wardrobe, based on which the algorithm will create a clothing composition.

Clothes data to be transmitted should include following informations:
* The temperature range in which the garment performs best.
* Name of the garment template.
* The color of the garment.
* Additional weather conditions the garment can handle.
* What part of the body this garment is designed for.

The code responsible for sending data to Firestore server:
```dart
Future<void> saveCloth(FirebaseAuth auth) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    ClothType clothType = ClothType.values.elementAt(type);
    //users.add({'userID': userID});
    users
        .doc(auth.currentUser.uid)
        .set({'email': auth.currentUser.email, 'userID': auth.currentUser.uid});
    users.doc(auth.currentUser.uid).collection(clothTypeName).add({
      'temperature': temperatureRating,
      'snow': snow,
      'rain': rain,
      'sun': sun,
      'wind': wind,
      'dir': dir,
      'color': color
    });
  }
```

### *Data Fetching*

On the server, the data is stored in four separated collections that correspond to head, upper body, lower body, and foot garment types. All of these collections are children of the parent document that is assigned to our account. Unfortunately, Firebase does not allow us to access the sub-collections from within the document ([DocumentSnapshot](https://firebase.google.com/docs/reference/android/com/google/firebase/firestore/DocumentSnapshot)), so we had to perform the operation four times while retrieving the data.

```dart
void getGarments(FirebaseAuth auth) async {
    List<QueryDocumentSnapshot> temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('head')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    headwear = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('top')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    top = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('legs')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    legs = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('feet')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    feet = temp;
    temp = [];
    userCollections = await users.doc(auth.currentUser.uid).get();
    notifyListeners();
  }
```
## Algorithm
In the app, the most important factor is the algorithm that suggests clothes based on weather conditions. Below is a simplified flowchart of the clothing suggestion and display. In the diagram, the current temperature represents the median temperature for the next X hours (for now it's 10 hours).
![Clothing Proposal Algorithm Schema](./github/img/Clothing_Proposal_Algorithm.png)
### Creating a Model
When creating a new Clothing object, the program checks what weather conditions will occur in the next X hours. To do this, the weather ID that OpeWeatherMap passes to us via its API is checked. The weather ID is a three-digit code that describes the exact weather phenomenon. There are seven main groups of weather conditions, which are subdivided into minor, more accurate weather descriptions. Below We present the main weather groups [Full description of Weather Groups](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2)

| Weather Group | Description  |
| ------------- | ------------ |
| 2XX           | Thunderstorm |
| 3XX           | Drizzle      |
| 5XX           | Rain         |
| 6XX           | Snow         |
| 7XX           | Atmosphere   |
| 800           | Clear Sky    |
| 80X           | Clouds       |

Weatherdrobe details four types of weather phenomena: Rain, Snow, Strong Wind and Strong Sun, so the application analyses the received data from the OpenWeatherMap server as follows:
| Weather Condition | ID          |
| ----------------- | ----------- |
| Rain              | [200 - 531] |
| Snow              | [600 - 622] |
| Wind              | 771, 781    |
| Sun               | 800         |

When creating a model, the algorithm will prioritise those garments that had compatibility with a given weather condition ticked during creation. In this way, on a rainy day, the algorithm will suggest a jacket first and clothes that are only suitable because of the temperature will appear in the next models.
### Graphic Attribution

In the application, apart from using the icons available as standard in flutter, and the usual emoji - I also used icons made available on the internet for free use. Below I present all the information about the authors of the graphics I used for this project.

- [Umbrella Icon used in App Logo](https://pixabay.com/pl/illustrations/sylwetka-cz%C5%82owieka-parasol-deszcz-5351473/)
- [Clothing templates](https://www.flaticon.com/packs/beautiful-clothes?word=clothes) made by 'Freepik' from Flaticon
- [Face Detection Icon](https://www.flaticon.com/free-icon/face-detection_2706938?term=face&page=1&position=18&page=1&position=18&related_id=2706938&origin=search)  used in Character Model made by 'Freepik' from Flaticon
- [Model Graphic](https://www.vecteezy.com/vector-art/133891-free-cartoon-fat-and-slim-woman-and-man-vector) used as Character model, made by xiayamoon from Vecteezy
- [Scarf Icon](https://www.flaticon.com/premium-icon/scarf_1175640?term=scarf&page=1&position=18&page=1&position=18&related_id=1175640&origin=search) made by 'Freepik' from Flaticon
- [Gloves Icon](https://www.flaticon.com/premium-icon/winter-gloves_5173853?term=winter%20gloves&related_id=5173853) made by 'dreamicons' from Flaticon
- [Umbrella Icon](https://www.flaticon.com/free-icon/umbrella_949816?term=umbrella&page=1&position=11&page=1&position=11&related_id=949816&origin=search) made by 'dreamicons' from Flaticon
- [Mannequin Graphic](https://www.freepik.com/free-vector/clothes-modeling-flat-illustration-with-fashion-designers-developing-new-models-cloth_14662516.htm#page=1&query=mannequin&position=39&from_view=search) made by 'macrovector' from Freepik
- [Wardrobe Background Image](https://www.freepik.com/free-vector/wardrobe-cloakroom-interior-realistic_6173733.htm#page=1&query=wardrobe&position=33&from_view=search) made by 'macrovector' from Freepik