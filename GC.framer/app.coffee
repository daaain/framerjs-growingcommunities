# This imports all the layers for "Growing Communities" into growingCommunitiesLayers2
sketch = Framer.Importer.load "imported/Growing Communities"

pageComp = new PageComponent
	width: Screen.width
	height: Screen.height
	scrollVertical: false
	backgroundColor: 'transparent'

# Parallax background
Fruits = sketch.FruitBackground
Fruits.x = Fruits.y = 0
Fruits.visible = true
pageComp.on Events.Move, (event, param, param2) ->
	Fruits.x = Math.min(event.x / 4, 0)

# Pages
pageStrings = ['LaunchScreen', 'Credits', 'RideShare', 'Profile']
pages = {}
for pageName in pageStrings
	pages[pageName] = sketch[pageName]
	pages[pageName].visible = true
	pages[pageName].y = 0
	pages[pageName].subLayersByName('Background')[0].visible = false
	pageComp.addPage(pages[pageName])

sections = {
	My_account: pages['Profile'],
	Veggie_bags: pages['Credits'],
	Collection_points: pages['Credits'],
	Collection_share: pages['RideShare']
}

for key, value of pages.LaunchScreen.subLayers
	value.on Events.Click, (event, layer) ->
	    pageComp.snapToPage(sections[layer.name], true)
