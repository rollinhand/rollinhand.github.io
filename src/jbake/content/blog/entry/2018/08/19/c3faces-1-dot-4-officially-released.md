type=post
title=C3Faces 1.4 officially released
date=2018-08-19
category=Entwicklung
tags=Java, C3Faces, JSF
~~~~~~
C3Faces is a chart library for JSF based on c3.js. I want to announce the fourth 
official version of this library released to 
[Maven central](https://search.maven.org/#artifactdetails%7Corg.kivio%7Cc3faces%7C1.0%7Cjar)
coming with dynamic category-based axes.

<!--more-->

C3Faces 1.4 fixes bug #2 filed as not updating categories on dynamic changes.
Using the _axis_ attribute with categories will still keep fixed category names
until the whole diagram is reloaded in your web-session (or session is restarted).
If you want to react on dynamic changes, use the _axis_ attribute without
fixed category names and use the newly introduced _Xkey_ class to define
dynamic category names for X-axis (it is only available for X-axis).

An example for clarification:

**JSF**:

```
<c3:line id="chart" data="#{dashboardViewBean.data}" >
	<c3:axes>
		<c3:axisX type="category" />
	</c3:axes>
</c3:line>
```

**Bean**:

```
private final Data data = new Data();
...

// New dynamic view for categories on X-axis
C3ViewDataSet categoriesView = new C3ViewDataSet(getMonths());
data.getDataSets().add(categoriesView);
data.addChild(new XKey(categoriesView.getId()));
```

This is it. After new data is added, you have to refresh the C3ViewDataSet
programmatically.

## Showcase update
If you want to see version 1.2 with axis configuration in action, please visit
the [official showcase](http://c3faces.kivio.org).

## Further information 
Changelog about further changes between previous version and the present one
can be found in the official [Changelog](https://github.com/rollinhand/c3faces/blob/master/CHANGELOG.md) 
in the GitHub repository.

Have fun while playing around with C3Faces and if you find any issues or have
suggestions for new features please [leave a comment](https://github.com/rollinhand/c3faces/issues).
