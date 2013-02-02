<h1>JLActionsheet</h1>
An easy to use and customize replacement to the stock UIActionSheet<br>
<h2>Installation</h2>
<hr>
Copy contents of the 'Sources' folder to your project
<h2>Use</h2>
<hr>
The JLActionSheet can be treated just like you would a UIActionSheet.  Initialize it with the title, delegate, cancel title and any other button titles either through the instance initialization or the class helper method.<br><br>Code uses ARC and needs the QuartzCore framework<br><br>

<u>Initialization</u><br>
+sheetWithTitle: delegate: cancelButtnTitle: otherButtonTitles:
-initWithTitle: delegate: cancelButtonTitke: otherButtonTitles:

<u>Style</u> : Set the style of the action sheet through the 'style' property of the JLActionSheet.  Currently support styles are in the JLActionSheetStyle class and are STEEL, SUPERCLEAN and CLEANBLUE<br><br>
<u>Presentation Methods</u><br>
showInView:<br>
showOnViewController:<br>
showFromBarItem: onView:<br>
showFromBarItem: onViewController<br>