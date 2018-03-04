---
layout: post
title: C3Faces 1.2 officially released
date: 2018-03-04
category: Entwicklung
tags: Java C3Faces JSF 
---
C3Faces is a chart library for JSF based on c3.js. I want to announce the second
official version of this library released to 
[Maven central](https://search.maven.org/#artifactdetails%7Corg.kivio%7Cc3faces%7C1.0%7Cjar)
coming with category-based axes and new elements in the taglib to manipulate axes.

<!--more-->

## Version 1.2 now supports category-based axes. 
Now you can choose between indexed and category-based axes. Therefore I introduced
new elements in the taglib: axes, axisX and axisY.

As with the elements of gridX and gridY, axisX and axisY enables you to adjust the
type, height and visibility of your axes. The outer element axes supports rotation of
the axes.

Using a category based axis you might write something like this:
```
<c3:bar data="#{chartTypesBean.data}">
    <c3:axes>
        <c3:axisX type="category" categories="{'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'}" />
        <c3:axisY show="false" />
    </c3:axes>
</c3:bar>
```

The X-axis will be no longer labeled with numbers from 1 to 7, but with labels
from Mon to Sun in the order of the array's elements.

If you use categories programmatically there is a new class called _C3Category_
which takes a list or an array of Strings as constructor parameter. **But note:** The
returning value inside is always a Set of strings. Duplicates are not taken into account
because categories should be always unique. Additional details can be found in the 
[official documentation of C3.js](http://c3js.org/reference.html#axis-x-categories).

In the above example Y-axis is not visible in the diagram.

## Showcase update
If you want to see version 1.2 with axis configuration in action, please visit
the [official showcase](http://c3faces.kivio.org).

## Further information 
Changelog about further changes between previous version and the present one
can be found in the official [Changelog](https://github.com/rollinhand/c3faces/blob/master/CHANGELOG) 
in the GitHub repository.

This post was updated to version 1.2 because prior version contained a bug
which lead to non working axis configuration.

Have fun while playing around with C3Faces and if you find any issues or have
suggestions for new features please [leave a comment](https://github.com/rollinhand/c3faces/issues).