# Project 3 - *Flixter*

Submitted by: **Mingxuan Qu**

**Flixter** is an app that introduces networking ... [TODO] 

Time spent: **30** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] Implement network call and table view to display a list of movies currently playing (title, description, image)
- [x] App has a collection view with the same list of movies
- [x] Uses a tab bar controller to switch between collection view and table view screens
 
The following **optional** features are implemented:

- [x] Make an additional network call to another end-point.	
- [x] Allow users to scroll when context items are off-screen (table view implemention)

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNDQwMzVkZmNjYzYxYTJkNDM5NzJhNjliOWY3MGE3Y2FiNGRkMjhhYiZjdD1n/7skQcObhLfCV4JdoS9/giphy.gif)


## Notes
Poster and backdrop path could be nil, so wrap them in optional value in the struct in case of JSON parsing error. On the other hand, don't forget to unwrap them when loading the images in the controller views. 
## License

    Copyright 2023 Mingxuan Qu

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
