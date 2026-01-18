#import "bs_icons.typ": svg_map

/// Function to create a Boostrap icon
/// 
/// - file (str): The file to load
/// - height (height unit): the target height
/// - color (typst color): the target color
#let bsicon(name, height: 0.66em, color: "black", baseline: 0%,..args) = {
  if name not in svg_map {
    panic("Icon '" + name + "' not found. Visit https://icons.getbootstrap.com/ for all available icon names.")
  }
  
  let svg_content = svg_map.at(name)

  let color_hex = if type(color) == str {
    color
  } else {
    color.to-hex()
  }

  let svg_complete = "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 16 16\" fill=\"" + color_hex + "\">" + svg_content + "</svg>"

  box(image(bytes(svg_complete), format: "svg", height: height), baseline: baseline, ..args)
}
