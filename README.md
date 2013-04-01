<h1>JLActionsheet</h1>
An easy to use and customize replacement to the stock UIActionSheet.  A sample project is included.<br><br>
<img src="http://jloewy.com/frameworks/JLActionSheet/Demo.png"><img src="http://jloewy.com/frameworks/JLActionSheet/Steel.png"><img src="http://jloewy.com/frameworks/JLActionSheet/CleanBlue.png"><br>
<h2>Installation</h2>
<hr>
Copy contents of the 'Sources' folder to your project
<h2>Use</h2>
<hr>
The JLActionSheet can be treated just like you would a UIActionSheet.  Initialize it with the title, delegate, cancel title and any other button titles either through the instance initialization or the class helper method.<br><br>Code uses ARC and needs the QuartzCore framework<br><br>

<u>Initialization</u><br>
+sheetWithTitle: delegate: cancelButtonTitle: otherButtonTitles:<br>
-initWithTitle: delegate: cancelButtonTitle: otherButtonTitles:<br><br>

<u>Style</u><br> Set the style of the action sheet through the 'style' property of the JLActionSheet.  Currently support styles are in the JLActionSheetStyle class and are STEEL, SUPERCLEAN, FERRARI and CLEANBLUE<br><br>
<u>Presentation Methods</u><br>
showInView:<br>
showOnViewController:<br>
showFromBarItem: onView:<br>
showFromBarItem: onViewController<br><br>

<u>Block Support</u><br>
Block support is available for JLActionSheet.  You can set two different block variables, clickedButtonBlock and didDismissBlock.  Blocks are given a higher priority since they have to explicitly be set, i.e. when their block gets set it gets called instead of its related delegate method.<br>
setClickedButtonBlock:<br>
setDidDismissBlock:<br>

<u>To Do</u><br>
(1) When showing from a barbuttonitem your JLActionSheet needs to be an instance variable<br>

<h1>License</h1>
If you end up using JLActionSheet in your project shoot me an email and let me know so I can check it out because I think thats cool,  JasonLoewy@gmail.com<br><br>

The MIT License (MIT)
Copyright (c) 2013 Jason Loewy

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
<br><br>
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
<br><br>
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.