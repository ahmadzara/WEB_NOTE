> 1. Run Sass with node-sass (node.js & npm) ==>

Node-sass is a library that provides binding for Node. js to LibSass.

install node.js and check the version ==>
- node -v
- npm -v
- npm install
- npm i express --save ==> npm install this will save all your installed core packages into the dependency section in the package.

update the node package manager ==>
1. npm update -g
2. npm install npm@latest -g
3. npm install -g npm@next

install sass globally using nodejs ==>
- npm install -g sass
- sass --help
- sass --version

go to npmjs.com ==> install (node-sass) package
- npm install node-sass

on cmd or terminal run ==>
- npm init (choose name and other info and click yes)
- npm install node-sass
- in package.json change ==>
"scripts": {
   "<name for npm run>": "<npm name> -w <.scss file folder name> -o <output folder for compiled file> --recursive"
-w ==> --watch ==> watch the changes
-r ==> --recurvise ==> recursively watch the directory
-o ==> --output ==> shows the output
finall edit ==>
},
"scripts": {
   "sass": "node-sass -w scss/ -o assets/css --recursive"
},

run sass with ==> npm run <name> ==> npm run sass

> 2. compile SASS to CSS without NodeJS ==>
install extention (sass) and (sass live compiler) on vscode
click on watch sass
