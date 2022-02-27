# NewsApp
This app collects News from newsapi.org API using options to filter the search and shows the articles in a list. Then, the user can see the detail of each article by tapping on it. Furthermore, if the user wants more information about the article, the url of the source is provided.


## Code Architecture
The architecture that has been used is MVVM:

### Model
Only one model, which represents the news. I have structured the model based on the information gathered from the documentation in https://newsapi.org/docs/
The property *articles* follows the same structure as in the API: a list of Article. So, I have created another struct called Article inside News, with the properties of the articles obtained from the doc. 


### View
There are 4 views in the App:
- LoadNewsView
- ShowArticlesView
- ArticlesListView
- ArticleView


**LoadNewsView**
I have decided to create a first view that works as a landing page. The user sees a welcome message and a description of the app. The reason why I did this is because in the future the user should be able to choose the search options before actually tapping the Search Button.

When the Search Button is tapped, the news are read from the api usign the default options (language = french)

If it succeeded, then a message appears showing the number of articles found, together with a button to show the list of articles

Moreover, I included a "restart" button that allows the user to start over (in the future, change the search options and search again)

If it does not succeed, an error message is printed in the screen in red.


**ShowArticlesView**
When the Show Articles is tapped, we navigate to this view. This view is composed only of a list that displays the articles at each row. In order to keep it cleaner, I created a sub-view for the rows of the list.


**ArticlesListView**
The sub-view for the rows of the list shows the title, source and image of the article. When a row of the list is tapped, we navigate to the last view, where the details of that article are displayed.


**ArticleView**
In this last view, the details of the article are displayed. In a VStack, it shows the Title, Image, Description and the url to the source.


### View Model
The view model is used as an interface between the view and the model. In this case, we used to read the API and store the data in an object. This object, a list of articles, is published, meaning that we will be able to access it anywhere in the app. 

I have created 3 functions:
- get the news
- get the url
- get the options

I decided to structure it this way because it the logic that I would follow: first I need the options that I will use in my url, then I create the url using those options, and finally I read the news using the URLSession method that requires the url that I just created. Finally, I store the data in my published array of articles.

It was important to take into account the fact that URLSession calls the api asyncronously, so I had to use closures. I call the completion when:
- there is an error
- success, inside the dispatchgroup method to make sure that I call it when the process is over

For the moment, to keep it simple I use thefault values for the options (only articles in french). But the functions are ready to accept options as an input, so in future versions it could be used for the user to choose the options for the search.


### Constants file
I have decided to create this file in order to keep all the constant (static) parameters in one place, and always use those.


## Problems encountered
The development of the app was quite smooth in general, but I was stuck with a few issues:

### Model / View
At first I could not properly display the articles in the list, since only one or two (out of 20) were displayed. The cause of this issue was the fact that I had not created a unique ID for each article.
**--> SOLUTION:** add a property inside the struct Article to store a unique id, using **UUID().uuidString**


### ViewModel
I was stuck for a while because I did not manage to properly decode the data. 
**--> SOLUTION:** I found out that I had to use a Decoding Strategy for the date.


### Tests
The basic Unit tests and UI tests were quite simple. However, I had to spent some time doing research on how to make tests for async functions. I found 2 solutions:
**--> SOLUTION UI Tests:**  using the **.waitForExistence(timeout: 5)**
**--> SOLUTION Unit Tests:** - using **expectations** / **waitForExpectations(timeout: 3)** 


## Other
In the documentation you can find 3 methods for the API KEY. I have used the one that I knew, even if it is indicated that is not the safest, since the api key is appended in the url. However, in order to save some time I decided that it was not a priority for this exercice to do the research on the other methods.


## Time to develop the exercice
I have used about 4h30 hours for the exercice:

- **30 min** reading the documentation of the API in https://newsapi.org/docs/ and setting up the code structure
- **1h30** with the Model + View Model + a dummy view to test the app
- **1h** coding and formating the views
- **1h** for the tests: most of the time with the problems that I have previously mentioned
- **30 min** on the documentation (README)

