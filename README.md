youemel
=======

This project produces UML class diagrams from a directory containing Matlab classes, using graphviz notation. The goal will be to reflect the various aspects of Matlab classes in a UML-like representation, while providing quick access to the corresponding file content.

## Example
Below is an example of running the youemel function on a directory of classes for another project:
```
youemel('C:\Users\nickroth\workspace\mAware\aware')
```
This command produces the following Graphviz DOT file: [Example DOT File](https://gist.github.com/rothnic/24cff4442824a596fdeb)

If you open the DOT file within GVEdit, you will get the following image:

#### Example Class Diagram
![example class diagram](http://i.imgur.com/Ewlx6De.png)

#### Use Within Matlab
If you open the DOT file within GVEdit, you can save the file as a SVG file. When doing this there will be active hyperlinks. You may need to make sure the dpi setting in the dotfile is removed for it to appear correctly. When saved out as an SVG, you can open it in Matlab with:
```
web('C:\Users\nickroth\workspace\youemel\dotfile.svg')
```
A web browser will pop up with the diagram and active hyperlinks. An example is shown below where I just clicked and am still hovering over one of the links. Matlab just navigated to and highlighted the code that is referenced in the link.
##### Browsing Classes in Matlab
![Example Matlab Class Browsing](http://i.imgur.com/ut1FPJB.png)

## Advanced Usage
TBD (Walk through directly working with the UML classes and modifying graphviz appearance)

## Dependencies
Currently, the youemel function is used to generate a file named dotfile.dot, which can then be opened and viewed with gvedit.exe, which is included with the Graphviz package.

### Graphviz
Download from [Graphviz.org](http://www.graphviz.org/Download_windows.php).

### Enhanced RDIR
Included in the project since it doesn't exist on Github. You can find the latest version from [Matlab File Exchange](http://www.mathworks.com/matlabcentral/fileexchange/32226-recursive-directory-listing-enhanced-rdir).

## References
[UML 2.5 Specification](http://www.omg.org/spec/UML/2.5/Beta2/PDF/)

[GraphViz Documentation](http://www.graphviz.org/doc/info/shapes.html)

## Updates
#### 9/1/14
- Refactored project to use objects. This separates the organization/relationships portion from the graphviz part a little bit. Mostly it provides a way to modify how the graphviz diagrams end up looking.
- Properties and methods are styled according to UML
- Properties, methods, and class now include hyperlinks if exported with SVG. These hyperlinks intend to provide navigation to the location where they are declared. Future work needs to be done to make sure the correct location is used. Note: you must view the svg file from within Matlab's browser for the linking to work.
- Deprecated getUmlDotHeader.m and dotStringFromClass.m
